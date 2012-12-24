function [gamedata,finalscore,complete] = parse_tsv (filename)
 % Given a FILENAME it returns three outputs: GAMEDATA, FINALSCORE,
 % and COMPLETE.
 % 
 % GAMEDATA is a cell array with the following cells
 %   GAMEDATA{1}  -> turns
 %   GAMEDATA{2}  -> player at each turn
 %   GAMEDATA{3}  -> round at each turn
 %   GAMEDATA{4}  -> real time at the beginning of each turn
 %   GAMEDATA{5}  -> Cards in each open card slot, at each turn
 %   GAMEDATA{6}  -> How many cards remain in the deck, at each turn
 %   GAMEDATA{7}  -> Hand cards of current player at the beginning
 %                   of the turn
 %   GAMEDATA{8}  -> Bridges occupied by current player at the
 %                   beginning of the turn 
 %   GAMEDATA{9}  -> Islands occupied by current player at the
 %                   beginning of the turn 
 %   GAMEDATA{10} -> All actions performed by current player duing
 %                   this turn. Actions are separated by ';'. The
 %                   syntax for actions is
 %                        1:'card'                for discarding
 %                        2:'bridge'('card-pair') for destroying
 %                        3:'bridge'('card')      for building
 %                        D:'card'('O|D')         for drawing from 
 %                                                the deck or an 
 %                                                open card.
 %   GAMEDATA{11} -> Hand cards of current player at the end
 %                   of the turn
 %   GAMEDATA{12} -> Bridges occupied by current player at the
 %                   end of the turn 
 %   GAMEDATA{13} -> Islands occupied by current player at the
 %                   end of the turn      
 %   GAMEDATA{14} -> Score of current player
 %
 % GAMESCORE is a cell array with final scores.
 %   GAMESCORE{1} and GAMESCORE{2} contains the name of the first
 %   player and the final score for the first player. Analogously,
 %   GAMESCORE{3} and GAMESCORE{4} contains the respectiv
 %   information for the second player.
 %  
 % COMPLETE is a boolean variable that is 1 if the game reached the
 % final state. Namely, third round, with deck and open card empty.
 
 fid=fopen(char(filename));
 %turn\tplayer\tround\ttime\topencars\tndeckcards\thand_i\tbridges_i\tmathuna_i\tactions\thand_f\tbridges_f\tmathuna_f\tscore\
 gamedata = textscan(fid,'%d\t%s\t%d\t%f\t%s\t%d\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%d','HeaderLines',1,'Delimiter','\t');
 fclose(fid);
 % TODO: fix this!
 
 wholestring = textread(filename,'%s');

 if (strcmp(wholestring{end-5},'SCORES:'))
     %finalscore = textscan(fid,'FINAL SCORES: %s:%d %s:%d','HeaderLines',gamedata{:,1}(end-1),'Delimiter',' ')
     finalscore{1} = wholestring{end-4};
     finalscore{2} = wholestring{end-3};
     finalscore{3} = wholestring{end-1};
     finalscore{4} = wholestring{end};
     hasscores = 1;
 else
     finalscore = {'','','',''};
     hasscores = 0;
 end
 
 if ((gamedata{3}(end) > 2) && ...
     (strcmp(gamedata{5}(end),'') && ...
     (gamedata{6}(end) == 0) && ...
      hasscores))
     complete = 1;
 else
     complete = 0;
 end
 
end