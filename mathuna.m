function mathuna
%%

%% Parameters for positions and colors of figures and some handles
% The position of the game figure will be [figX1,figX2,figY1,figY2]
figX1 = 0;
figX2 = 1000;
figY1 = 0;
figY2 = 500;
% The position of the board axes will be [boardX1,boardX2,boardY1,boardY2]
boardX1 = 20;
boardX2 = 420;
boardY1 = 20;
boardY2 = 420;
cardFS = 10; % Default font size of cards handles
P1color = 'r'; % Player 1 color
P2color = 'm'; % Player 2 color
opencardcolor = 'y'; % color for opencards handles
deckcolor = 'b'; % color for deck pile handle

%% Create and hide the GUI figure as it is being constructed.
gamefigure = figure('Visible','off','Tag','gamefigure','Position',[figX1,figY1,figX2,figY2]);

% To capture mouse and keyboard
set(gamefigure,'WindowKeyPressFcn',@keypress);
set(gamefigure,'WindowButtonUpFcn',@click);

%% Create axes and display board
boardim=imread('board.jpg');
ha = axes('Units','Pixels','Position',[boardX1,boardY1,boardX2,boardY2]);
imshow(boardim);

%% Game messages
hmessages = uicontrol('Style','text','String','Press start to begin the game',...
    'Position',[50,430,350,50],'FontSize',20, ...
    'ForegroundColor','white','BackgroundColor','black'); % Display instructions
hscore = uicontrol('Style','text','String','Score',...
    'Position',[710,450,220,30],'FontSize',20); % Display the current score
hround = uicontrol('Style','text','String','Round',...
    'Position',[560,450,140,30],'FontSize',20); % Display the current round

%% Game highlevel control
hquitbutton = uicontrol('Style','pushbutton',...
    'String','Quit','Callback',@hquitbutton_Callback,...
    'Position',[840,380,70,30]); % Quit game
hstartbutton = uicontrol('Style','pushbutton',...
    'String','Start','Callback',@hstartbutton_Callback,...
    'Position',[760,380,70,30]); % Start the game
hmodemenu = uicontrol('Style','popup',...
    'String','1VS2|1VSR|RVSR','Callback',@hmodemenu_Callback,...
    'Position',[650,375,100,30]); %

%% Drawable cards
hopencard1 = uicontrol('Style','pushbutton',...
    'String','','Callback',@hopencard1_Callback,...
    'Position',[460,330,70,90],'FontSize',cardFS,'BackgroundColor',opencardcolor);
% 1th open card
hopencard2 = uicontrol('Style','pushbutton',...
    'String','','Callback',@hopencard2_Callback,...
    'Position',[460,230,70,90],'FontSize',cardFS,'BackgroundColor',opencardcolor);
% 2nd open card
hopencard3 = uicontrol('Style','pushbutton',...
    'String','','Callback',@hopencard3_Callback,...
    'Position',[460,130,70,90],'FontSize',cardFS,'BackgroundColor',opencardcolor);
% 3th open card
hdeck = uicontrol('Style','pushbutton',...
    'String','Deck','Callback',@hdeck_Callback,...
    'Position',[460,30,70,90],'FontSize',15,'BackgroundColor',deckcolor);
% Deck pile

%% Player cards
hP1card1 = uicontrol('Style','pushbutton',...
    'String','Player 1','Callback',@hP1card1_Callback,...
    'Position',[900,230,70,90],'FontSize',cardFS,'BackgroundColor',P1color);
% P1 1th card
hP1card2 = uicontrol('Style','pushbutton',...
    'String','Player 1','Callback',@hP1card2_Callback,...
    'Position',[820,230,70,90],'FontSize',cardFS,'BackgroundColor',P1color);
% P1 2nd card
hP1card3 = uicontrol('Style','pushbutton',...
    'String','Player 1','Callback',@hP1card3_Callback,...
    'Position',[740,230,70,90],'FontSize',cardFS,'BackgroundColor',P1color);
% P1 3th card
hP1card4 = uicontrol('Style','pushbutton',...
    'String','Player 1','Callback',@hP1card4_Callback,...
    'Position',[660,230,70,90],'FontSize',cardFS,'BackgroundColor',P1color);
% P1 4th card
hP1card5 = uicontrol('Style','pushbutton',...
    'String','Player 1','Callback',@hP1card5_Callback,...
    'Position',[580,230,70,90],'FontSize',cardFS,'BackgroundColor',P1color);
% P1 5th card

hP2card1 = uicontrol('Style','pushbutton',...
    'String','Player 2','Callback',@hP2card1_Callback,...
    'Position',[900,130,70,90],'FontSize',cardFS,'BackgroundColor',P2color);
% P1 1th card
hP2card2 = uicontrol('Style','pushbutton',...
    'String','Player 2','Callback',@hP2card2_Callback,...
    'Position',[820,130,70,90],'FontSize',cardFS,'BackgroundColor',P2color);
% P1 2nd card
hP2card3 = uicontrol('Style','pushbutton',...
    'String','Player 2','Callback',@hP2card3_Callback,...
    'Position',[740,130,70,90],'FontSize',cardFS,'BackgroundColor',P2color);
% P1 3th card
hP2card4 = uicontrol('Style','pushbutton',...
    'String','Player 2','Callback',@hP2card4_Callback,...
    'Position',[660,130,70,90],'FontSize',cardFS,'BackgroundColor',P2color);
% P1 4th card
hP2card5 = uicontrol('Style','pushbutton',...
    'String','Player 2','Callback',@hP2card5_Callback,...
    'Position',[580,130,70,90],'FontSize',cardFS,'BackgroundColor',P2color);
% P1 5th card

%% Game actions
hdiscardmenu = uicontrol('Style','popup',...
    'String',' ','Callback',@hdiscardmenu_Callback,...
    'Position',[840,70,80,30]); % Menu to discard player cards
hdiscardtitle = uicontrol('Style','text','String','Discard',...
    'Position',[845,50,70,20]); % Message below hdiscardmenu
hdestroymenu = uicontrol('Style','popup',...
    'String',' ','Callback',@hdestroymenu_Callback,...
    'Position',[760,70,80,30]); % Menu to distroy a bridge
hdestroytitle = uicontrol('Style','text','String','Destroy',...
    'Position',[765,50,70,20]); % Message below hdestroymenu
hbuildmenu = uicontrol('Style','popup',...
    'String',' ','Callback',@hbuildmenu_Callback,...
    'Position',[680,70,80,30]); % Menu to build a bridge
hbuildtitle = uicontrol('Style','text','String','Build',...
    'Position',[685,50,70,20]); % Message below hbuildmenu

hfinishbutton = uicontrol('Style','pushbutton',...
    'String','Finish','Callback',@hfinishbutton_Callback,...
    'Position',[600,70,70,30]); % Pushbotton to finish a player turn

% Change units to normalized so components resize automatically.
set([gamefigure,ha,hmessages,hscore,hround,...
    hopencard1,hopencard2,hopencard3,hdeck,...
    hP1card1,hP1card2,hP1card3,hP1card4,hP1card5,...
    hP2card1,hP2card2,hP2card3,hP2card4,hP2card5,...
    hdiscardmenu,hdestroymenu,hbuildmenu,hfinishbutton,...
    hdiscardtitle,hdestroytitle,hbuildtitle...
    hstartbutton,hquitbutton,hmodemenu],...
    'Units','normalized');

%% Islands and bidges
% Islands
islandnames = {'Aloa', 'Bari', 'Coco','Duda','Elai','Faa','Gola','Huna','Iffi','Jojo','Kahu','Lale'};
isabr = ['ABCDEFGHIJKL'];
% Bridges
bridges = {'AB','AD','AH',...
    'BC','BD','BE','BF',...
    'CF','CG','CK',...
    'DE','DH',...
    'EF','EH','EI','EJ'...
    'FG','FJ',...
    'GJ','GK',...
    'HI','HL',...
    'IJ','IK','IL'...
    'JK',...
    'KL'};

% Positions in pixels
islandpos = [413,299;... %A
    225,267;... %B
    66,257;... %C
    370,221;... %D
    286,196;... %E
    140,217;... %F
    93,171;... %G
    382,143;... %H
    236,123;... %I
    166,155;... %J
    125,93;... %K
    237,47 ... %L
    ];
brecpositions = [307,342,303,311;... %AB
    377,390,243,262;... %AD
    399,426,163,182;... %AH
    142,111,283,283;... %BC
    334,352,254,228;... %BD
    259,274,253,222;... %BE
    166,158,262,238;... %BF
    90,123,248,233;... %CF
    57,84,227,203;... %CG
    39,42,209,175;... %CK
    353,320,220,214;... %DE
    365,365,199,168;... %DH
    195,162,211,215;... %EF
    324,351,191,167;... %EH
    284,264,175,149;... %EI
    209,182,187,169;... %EJ
    129,95,197,184;... %FG
    136,153,199,168;... %FJ
    116,147,160,155;... %GJ
    100,76,155,133;... %GK
    359,332,140,118;...%HI
    378,364,89,60;... %HL
    216,186,139,153;... %IJ
    184,151,102,93;... %IK
    281,282,98,63%IL
    152,130,131,111;... %JK
    144,178,75,63 ... % KL
    ];

%% Mappings
% index.() maps isabr and bridges strings to the their index
% isl2bridg.() maps isabr strings to the index of the bridges connected to that
% island.
% isl2bcount.() maps isabr strings to the number of bridges of that island.
for i = 1:length(isabr)
    isl = isabr(i);
    index.(char(isl))=i;
    bindexes = [];
    count = 0;
    for j=1:length(bridges)
        b = char(bridges(j));
        if(strcmp(isl,b(1)))
            count = count + 1;
            bindexes(count) = j;
        elseif(strcmp(isl,b(2)))
            count = count + 1;
            bindexes(count) = j;
        end
    end
    isl2bridg.(isl) = bindexes;
    isl2bcount.(isl) = length(bindexes);
end
for i = 1:length(bridges)
    b = char(bridges(i));
    index.(b)=i;
end

%% Deck
deck = ['ABCDEFGHIJKLABCDEFGHIJKL']; % Deck alphabet

%% Bridges parameters
bridgelw = 5; % line whith of the bridge (pixels)

%% Mathuna parameters
disx = 10; % Delta x from the island location to build Mathuna diamond
disy = 10; % Delta y from the island location to build Mathuna diamond

%% Players (1,2)
% Players structures
Phand = ['     ';'     '];
Pnotempcards = [0,0,0,0,0;0,0,0,0,0]; % Not empty cards
Pscore = [0,0];
usedbridge = zeros(2,length(bridges)); % birdges displayed
activematlh = zeros(2,length(isabr)); % island with mathuna
Pmode = [1,1];
Pnames = {'P1','P2'};

% Players Handles
Phbridges(1,:) = makebridges(P1color);
Phbridges(2,:) = makebridges(P2color);
Phismatlh(1,:) = makemathuna(P1color);
Phismatlh(2,:) = makemathuna(P2color);
Pcardshandles = [hP1card1,hP1card2,hP1card3,hP1card4,hP1card5; ...
    hP2card1,hP2card2,hP2card3,hP2card4,hP2card5];
menushandles = [hdiscardmenu,hdestroymenu,hbuildmenu];

%% Open cards
opencardhandles = [hopencard1,hopencard2,hopencard3];
emptyopencards = [0 0 0];

%% Saving data
fid = 1;
gamedata = {0,0,0,0,'',0};
lastactions = '';
pgamedata = {'','','';'','',''};
%% Game parameters
areweplaying = 0; % Control if the game is going or not
cplayer = 1; % Current player in turn
cdeckcard = 1; % Next card in the deck
cdeck = []; % Current deck
cround = 1; % Current round
flippause = 0;
allowfinish = 1;
allodmodechange = 1;
gamemode = 1;
areweprinting = 0;

%% Final game settings
% Assign the GUI a name to appear in the window title.
set(gamefigure,'Name','MATLHUNA 1')
% Move the GUI to the center of the screen.
movegui(gamefigure,'center')
% Make the GUI visible.
set(gamefigure,'Visible','on')

%% Callbacks
    function keypress(~,~)
        % Not used...
    end
    function click(~,~)
        % Not used...
    end

    function hstartbutton_Callback(~,~)
        % This function begin the game.
        % Set the three control variables for callbacks to 1:
        % ALLOWPAUSE, ALLORESTART, and AREWEPLAYING.
        % Finally calls @defaultinitround
        allodmodechange = 0;
        areweplaying = 1; % control all callbacks
        cplayer = 1; % Current player in turn
        cdeckcard = 1; % Next card in the deck
        cdeck = []; % Current deck
        cround = 1; % Current round
        Phand = ['     ';'     '];
        Pnotempcards = [0,0,0,0,0;0,0,0,0,0];
        Pscore = [0,0];
        usedbridge = zeros(2,length(bridges));
        activematlh = zeros(2,length(isabr));
        for p = 1:2
            for i = 1:length(isabr)
                set(Phismatlh(p,i),'Visible','off');
            end
            for b=1:length(bridges)
                bline = Phbridges(p,b);
                set(bline,'Visible','off');
            end
        end
        tic;
        defaultinitround();
        gamedata = {0,0,0,0,'',0};
        lastactions = '';
        pgamedata = {'','','';'','',''};
        fid = fopen(get_file_name(),'w');
        areweprinting = 1;
        printheader();
        updategamedata();
        updatepgamedata(cplayer);
        updatepgamedata(otherplayer(cplayer));
        exportdata1();
        if (gamemode  < 3)
        if (Pmode(cplayer) == 1)
            hidePcards (otherplayer(cplayer));
            showPcards (cplayer);
            for n = 1:3
                updatepopup(n,cplayer);
                deck2opencard(n); % place 3 open cards
            end
        else(Pmode(cplayer) == 2)
            %randomplayer(cplayer);
        end
        else
            while(areweplaying)
                randomplayer(cplayer); % R1
                randomplayer(cplayer); % R2
            end
        end
    end
    function hquitbutton_Callback(~,~)
        endgame();
        close(gamefigure);
    end
    function hmodemenu_Callback(hObj,~)
        if (allodmodechange)
            val = get(hObj,'Value');
            if (val == 2)
                Pmode(2) = 2; % random P2
                Pnames(2) = {'P2-R'};
            elseif(val == 3)
                Pmode(1) = 2; % random P1
                Pnames(1) = {'P1-R'};
                Pmode(2) = 2; % random P2
                Pnames(2) = {'P2-R'};
            end
            gamemode = val;
        else
            set(hObj,'Value',gamemode);
        end
    end

% Open cards
    function hopencard1_Callback(~,~)
        if (areweplaying)
            card = drawopencard(1);
            if (not(strcmp(card,'')))
                lastactions = [lastactions,';D:',card,'(O)'];
                hfinishbutton_Callback();
            end
        end
    end
    function hopencard2_Callback(~,~)
        if (areweplaying)
            card = drawopencard(2);
            if (not(strcmp(card,'')))
                lastactions = [lastactions,';D:',card,'(O)'];
                hfinishbutton_Callback(0,0);
            end
        end
    end
    function hopencard3_Callback(~,~)
        if (areweplaying)
            card = drawopencard(3);
            if (not(strcmp(card,'')))
                lastactions = [lastactions,';D:',card,'(O)'];
                hfinishbutton_Callback(0,0);
            end
        end
    end

% Deck
    function hdeck_Callback(~,~)
        if (areweplaying)
            card = drawfromdeck(cplayer);
            lastactions = [lastactions,';D:',card,'(D)'];
            hfinishbutton_Callback(0,0);
        end
    end

% Player cards
    function hP1card1_Callback(~,~)
        % Not used...
    end
    function hP1card2_Callback(~,~)
        % Not used...
    end
    function hP1card3_Callback(~,~)
        % Not used...
    end
    function hP1card4_Callback(~,~)
        % Not used...
    end
    function hP1card5_Callback(~,~)
        % Not used...
    end
    function hP2card1_Callback(~,~)
        % Not used...
    end
    function hP2card2_Callback(~,~)
        % Not used...
    end
    function hP2card3_Callback(~,~)
        % Not used...
    end
    function hP2card4_Callback(~,~)
        % Not used...
    end
    function hP2card5_Callback(~,~)
        % Not used...
    end

% Popup callbacks
    function hdiscardmenu_Callback(hObj,event)
        if (areweplaying)
            val = get(hObj,'Value');
            if (val > 1)
                s = get(menushandles(1),'String');
                selected = s(val);
                removecard(cplayer,selected);
                lastactions = [lastactions,';1:',selected];
                showPcards (cplayer);
                for n = 1:3
                    updatepopup(n,cplayer);
                end
                set(hObj,'Value',1);
            end
        end
    end

    function hdestroymenu_Callback(hObj,event)
        if (areweplaying)
            val = get(hObj,'Value');
            if (val > 1)
                s = get(menushandles(2),'String');
                selected = s(val,:);
                b = selected(1:2);
                cardpair = selected(5:6);
                destroybridge(cplayer,b,cardpair);
                showPcards (cplayer);
                for n = 1:3
                    updatepopup(n,cplayer);
                end
                set(hObj,'Value',1);
            end
        end
    end
    function hbuildmenu_Callback(hObj,~)
        if (areweplaying)
            val = get(hObj,'Value');
            if (val > 1)
                s = get(menushandles(3),'String');
                selected = s(val,:);
                b = selected(1:2);
                usedcard = selected(5);
                buildbridge(cplayer,b,usedcard);
                showPcards (cplayer);
                for n = 1:3
                    updatepopup(n,cplayer);
                end
                set(hObj,'Value',1);
            end
        end
    end

% Finish player turn
    function hfinishbutton_Callback(~,~)
        if (areweplaying && allowfinish)
            allowfinish = 0;
            % Allow finish is a hack to prevent pressing finish_button several times
            check_for_end ();
            if(areweplaying)
                updatepgamedata(cplayer);
                updatepgamedata(otherplayer(cplayer));
                exportdata2();
                lastactions = '';
                
                changeplayer();
                updategamedata();
                updatepgamedata(cplayer);
                updatepgamedata(otherplayer(cplayer));
                exportdata1();
                
                if (Pmode(cplayer) == 1)
                    flipcards(flippause);
                    defaultmessage();
                    for n = 1:3
                        updatepopup(n,cplayer);
                    end
                elseif(Pmode(cplayer) == 2)
                    randomplayer(cplayer);
                end
            end
            allowfinish = 1;
        end
    end
    function check_for_end ()
        if (sum(emptyopencards) == 3) % if the three opencards are empty..
            if (cround < 3)
                changeround(); % Next round
            elseif ((cround == 3) && ...
                    ((strcmp(getdestroyablesb(1),'')) && ...
                    (strcmp(getdestroyablesb(2),'')) && ...
                    (strcmp(getbuildablesb(1),'')) && ...
                    (strcmp(getbuildablesb(2),'')))) % No more moves
                endgame();
            end
        end
        if((cround > 1) && ...
                ((sum(usedbridge(2,:)) == 0) || ...
                (sum(usedbridge(1,:)) == 0)))
            % if one player has no bridges after round 1
            endgame();
        end
    end
    function randomplayer (player)
        %% Here random player should do its thing
        areweplaying = 0;
        for n = 1:3
            set(menushandles(n),'Visible','off');
        end
        exit = 0;
        if (gamemode == 3)
             showPcards (cplayer);
             showPcards (otherplayer(cplayer));
             pause(0.1);
        end
        while(exit == 0)
            options = [1];
            potdiscard = gethandcards(player);
            potbuild = getbuildablesb(player);
            potdistroy = getdestroyablesb(player);
            %%showPcards (player);
            if (not(strcmp(potdiscard,'')))
                options = [2,options];
            end
            if (not(strcmp(potdistroy,'')))
                if (gamemode == 2)
                options = [3,3,3,3,options];
                elseif(gamemode == 3)
                options = [3,options];
                end
            end
            if (not(strcmp(potbuild,'')))
                if (gamemode == 2)
                options = [4,4,4,4,4,4,4,4,options];
                elseif(gamemode == 3)
                options = [4,options];
                end
            end
            randoptions = randperm(length(options));
            action = options(randoptions(1));
            if (action == 1)
                % draw and finish
                exit = 1;
            elseif (action == 2)
                % discard rnd
                randdiscards = randperm(length(potdiscard));
                card = potdiscard(randdiscards(1));
                removecard(player,card);
                lastactions = [lastactions,';1:',card];
            elseif (action == 3)
                % distroy rnd
                randdistroy = randperm(length(potdistroy)/7);
                selected = randdistroy(1);
                init = 7*(selected-1) + 1;
                bridge = potdistroy(init:(init+1));
                cards = potdistroy((init+4):(init+5));
                destroybridge(player,bridge,cards);
            elseif (action == 4)
                % build rnd
                randbuild = randperm(length(potbuild)/6);
                selected = randbuild(1);
                init = 6*(selected-1) + 1;
                bridge = potbuild(init:(init+1));
                card = potbuild(init+4);
                buildbridge (player,bridge,card);
            end
        end
        %Drawing of card
        options = [];
        if (sum(Pnotempcards(player,:)) < 5)
            if (remainingcards() > 0)
                options = [4,options];
            end
            for n = 1:3
                if (emptyopencards(n) == 0)
                    options = [n,options];
                end
            end
            if (not(isempty(options)))
                randoptions = randperm(length(options));
                action = options(randoptions(1));
                if (action == 4)
                    card = drawfromdeck(player);
                    lastactions = [lastactions,';D:',card,'(D)'];
                else
                    card = drawopencard(action);
                    lastactions = [lastactions,';D:',card,'(O)'];
                end
            end
        end
        %% Like finish button
        updatepgamedata(cplayer);
        updatepgamedata(otherplayer(cplayer));
        exportdata2();
        lastactions = '';
        changeplayer();
        updategamedata();
        updatepgamedata(cplayer);
        updatepgamedata(otherplayer(cplayer));
        exportdata1();
        if (gamemode == 2)
            pause(0.5);
            showPcards (cplayer);
        elseif(gamemode == 3)
            showPcards (cplayer);
            showPcards (otherplayer(cplayer));
        end
        for n = 1:3
            set(menushandles(n),'Visible','on');
        end
        areweplaying = 1;
        %allowfinish = 1;
        %hfinishbutton_Callback(0,0); % Horrible!
        defaultmessage();
        
        for n = 1:3
            updatepopup(n,cplayer);
        end
        check_for_end ();
    end
%% Rounds and game ending
    function changeround ()
        if (cround < 3)
            if (sum(activematlh(1,:)) == sum(activematlh(2,:)))
                Pscore(1) = Pscore(1) + cround;
                Pscore(2) = Pscore(2) + cround;
            elseif (sum(activematlh(1,:)) > sum(activematlh(2,:)))
                Pscore(1) = Pscore(1) + cround;
            else
                Pscore(2) = Pscore(2) + cround;
            end
            cround = cround + 1;
        end
        %%changeplayer();
        defaultinitround();
    end
    function defaultinitround ()
        cdeckcard = 1;
        cdeck = randomizedeck();
        if (cround == 1) % only give cards at first round
            drawfromdeck(cplayer);
            drawfromdeck(otherplayer(cplayer));
            drawfromdeck(cplayer);
            drawfromdeck(otherplayer(cplayer));
            drawfromdeck(cplayer);
            drawfromdeck(otherplayer(cplayer));
        end
        %hidePcards (otherplayer(cplayer));
        %showPcards (cplayer);
        for n = 1:3
            %    updatepopup(n,cplayer);
            deck2opencard(n); % place 3 open cards
        end
        emptyopencards = [0 0 0];
        defaultmessage();
        updatescorem();
        updateroundm();
        updatedeckm();
    end

    function endgame()
        areweplaying = 0;
        Pscore(1) = Pscore(1) + sum(activematlh(1,:)) ;
        Pscore(2) = Pscore(2) + sum(activematlh(2,:));
        updatescorem();
        if (Pscore(1) == Pscore(2))
            updatemessage('Tied game!');
        elseif (Pscore(1) > Pscore(2))
            mess = ['Congratulations ', char(Pnames(1)), '!'];
            updatemessage(mess);
        else
            mess = ['Congratulations ', char(Pnames(2)), '!'];
            updatemessage(mess);
        end
        updatepgamedata(cplayer);
        updatepgamedata(otherplayer(cplayer));
        exportdata2();
        if (areweprinting)
            %% Add a final message w the final scores!
            fprintf(fid,'--------\nFINAL SCORES: %s:%d%s:%d',char(Pnames(1)),Pscore(1),char(Pnames(2)),Pscore(2));
            fclose(fid);
            areweprinting = 0;
        end
        if (gamemode == 3)
            pause(1);
            hstartbutton_Callback(0,0);
        end
    end

%% Update handles strings
    function updatepopup (n,player)
        % update discard (n=1),destroy(n=2), and build (n=3) popups
        s = '----------';
        if (player == 1)
            color = P1color;
        else
            color = P2color;
        end
        if (n == 1) % Discard
            options = sort(gethandcards(player));
            delta = 1;
        elseif (n == 2) % Destroy
            options = getdestroyablesb(player);
            delta = 7;
            % As we destroy the b from the otherplayer we switch colors
            if (player == 1)
                color = P2color;
            else
                color = P1color;
            end
        elseif (n == 3)
            options = getbuildablesb(player);
            delta = 6;
        end
        for i = 1:delta:length(options)
            s = [s,'|',options(i:(i+delta-1))];
        end
        set(menushandles(n),'String',s);
        set(menushandles(n),'ForegroundColor',color);
    end
    function buildbridge (player,bridge,card)
        switchbridge(player,bridge);
        removecard(player,card);
        lastactions = [lastactions,';3:',bridge,'(',card,')'];
        updatekahuna(player,bridge(1));
        updatekahuna(player,bridge(2));
    end
    function destroybridge (player,bridge,cards)
        switchbridge(otherplayer(player),bridge);
        removecard(player,cards(1));
        removecard(player,cards(2));
        lastactions = [lastactions,';2:',bridge,'(',cards,')'];
        updatekahuna(otherplayer(player),bridge(1));
        updatekahuna(otherplayer(player),bridge(2));
    end
    function removecard (player,card)
        for i = 1:5
            if strcmp(Phand(player,i),card)
                Phand(player,i) = ' ';
                Pnotempcards(player,i) = 0;
                break;
            end
        end
    end
    function showPcards (player)
        for i = 1:5
            set(Pcardshandles(player,i),'String',Phand(player,i));
        end
    end
    function hidePcards (player)
        for i = 1:5
            set(Pcardshandles(player,i),'String',['Player ',num2str(player)]);
        end
    end
    function defaultmessage ()
        if (areweplaying)
            updatemessage(['Player ' num2str(cplayer) '! your turn']);
        else
            updatemessage('Press start to begin the game');
        end
    end
    function updatescorem()
        set(hscore,'String',['Score: P1=',num2str(Pscore(1)),'; P2=',num2str(Pscore(2))]);
    end
    function updateroundm()
        set(hround,'String',['Round: ',num2str(cround)]);
    end
    function updatedeckm()
        set(hdeck,'String',['Deck (',num2str(remainingcards()),')']);
    end
    function updatemessage(m)
        set(hmessages,'String',m);
    end

%% Update visibility of objects
    function switchbridge (player,bridge)
        if (usedbridge(player,index.(bridge)) > 0)
            bline = Phbridges(player,index.(bridge));
            set(bline,'Visible','off');
            usedbridge(player,index.(bridge)) = 0;
        else
            bline = Phbridges(cplayer,index.(bridge));
            set(bline,'Visible','on');
            usedbridge(cplayer,index.(bridge)) = 1;
        end
    end
    function updatekahuna (player,isl)
        bindex = isl2bridg.(isl); % index of bridges of isl
        totalb = 0;
        for j = 1:length(bindex)
            b5 = char(bridges(bindex(j)));
            % total number of from player bridges in isl
            totalb = totalb + usedbridge(player,index.(b5));
        end
        if (totalb > isl2bcount.(isl)/2) % if is bigger than half...
            if (not (activematlh(player,index.(isl)))) 
                % if the mathuna is off, set it on
                set(Phismatlh(player,index.(isl)),'Visible','on');
                % remove bridges from the other player on the island
                bindex = isl2bridg.(isl);
                for q = 1:length(bindex) 
                    b = char(bridges(bindex(q))); % for each bridge
                    if (usedbridge(otherplayer(player),index.(b)) > 0) 
                        % if the other player has a bridge there
                        bline = Phbridges(otherplayer(cplayer),index.(b));
                        set(bline,'Visible','off'); % set it off
                        usedbridge(otherplayer(cplayer),index.(b)) = 0;
                        if (strcmp(isl,b(1))) % updatekahuna of the other island
                            updatekahuna (otherplayer(player),b(2));
                        else
                            updatekahuna (otherplayer(player),b(1));
                        end
                    end
                end
                activematlh(player,index.(isl)) = 1;
            end
        else
            if (activematlh(player,index.(isl)))
                set(Phismatlh(player,index.(isl)),'Visible','off');
                activematlh(player,index.(isl)) = 0;
            end
        end
    end
    function flipcards(p) % p = the time for pause
        if (cplayer == 2)
            showPcards (1);
            pause(p/2);
            hidePcards (1);
            pause(p/2);
            showPcards (2);
        else
            showPcards (2);
            pause(p/2);
            hidePcards (2);
            pause(p);
            showPcards (1);
        end
    end

%% Get info from handles
    function [s] = gethandcards(player)
        s = '';
        for i = 1:5
            if (Pnotempcards(player,i) > 0)
                s = [s,Phand(player,i)];
            end
        end
    end
    function [s] = getopencards ()
        s = '';
        for n = 1:3
            s = [s,get(opencardhandles(n),'String')];
        end
    end
    function [name] = getcardname(card) %% Not used I believe
        if (strcmp(card,' '))
            name = card;
        else
            name = islandnames(index.(card));
        end
    end
    function [result] = getdestroyablesb (player)
        result = '';
        temp = sort(gethandcards(player));
        for i = 1:length(temp)
            for j = (i+1):length(temp)
                b1 = [temp(j),temp(i)];
                b2 = [temp(i),temp(j)];
                s = '   (  )'; %BB (CC)
                if (potentialdestroy(b1,player))
                    s(1:2) = b1;
                    s(5:6) = b1;
                    result = [result,s];
                elseif (potentialdestroy(b2,player))
                    s(1:2) = b2;
                    s(5:6) = b2;
                    result = [result,s];
                elseif (strcmp(temp(j),temp(i)))
                    % when we have two of the same kind, any of the
                    % bridges on that island can be destroyed
                    bindex = isl2bridg.(temp(i));
                    for q = 1:length(bindex)
                        b3 = char(bridges(bindex(q)));
                        if (usedbridge(otherplayer(player),index.(b3)) > 0)
                            s(1:2) = b3;
                            s(5:6) = [temp(j),temp(i)];
                            result = [result,s];
                        end
                    end
                end
            end
        end
    end
    function [result] = getbuildablesb (player)
        result = '';
        temp = sort(gethandcards(player));
        for i = 1:length(temp)
            bindex = isl2bridg.(temp(i));
            for j = 1:length(bindex)
                b4 = char(bridges(bindex(j)));
                s = '   ( )';
                if ((usedbridge(1,index.(b4)) == 0) && ...
                        (usedbridge(2,index.(b4)) == 0))
                    s(1:2) = b4;
                    s(5) = temp(i);
                    result = [result,s];
                end
            end
        end
    end
    function [s] = getbridges (player)
        s = '';
        for i = 1:length(bridges)
            if (usedbridge(player,i) > 0)
                s = [s,'&',char(bridges(i))];
            end
        end
        if (length(s) > 0)
            s = s(2:end); %% remove the first char
        end
    end
    function [s] = getmathunas (player)
        s = '';
        for i = 1:length(isabr)
            if (activematlh(player,i) > 0)
                s = [s,char(isabr(i))];
            end
        end
    end

%% Draw functions
    function [card] = drawfromdeck (player)
        card = '';
        if ((remainingcards() > 0) && (sum(Pnotempcards(player,:)) < 5))
            card = cdeck(cdeckcard);
            cdeckcard = cdeckcard + 1;
            updatedeckm();
            givecard(player,card);
        end
    end
    function [card] = drawopencard(n)
        card = ''; %% TODO: some bug at the end of each turn, does not switch payer
        if ((emptyopencards(n) == 0) && (sum(Pnotempcards(cplayer,:)) < 5))
            card = get(opencardhandles(n),'String');
            givecard(cplayer,card);
            if (remainingcards() > 0)
                deck2opencard(n)
            else
                set(opencardhandles(n),'String',' ');
                emptyopencards(n) = 1;
            end
        end
    end
    function deck2opencard(n)
        card = char(cdeck(cdeckcard));
        cdeckcard = cdeckcard + 1;
        updatedeckm();
        set(opencardhandles(n),'String',card);
    end
    function givecard(player,card)
        for i=1:5
            if (Pnotempcards(player,i) == 0)
                Phand(player,i) = card;
                Pnotempcards(player,i) = 1;
                break;
            end
        end
    end

%% Make bridges and mathhuna objects functions
    function [handles] = makebridges(color)
        for i = 1:length(bridges)
            b = bridges(i);
            pos = brecpositions(i,:);
            handles(i) = line([pos(1) pos(2)],[pos(3) pos(4)],'LineWidth',bridgelw,'Color',color);
            set(handles(i),'Visible','off');
        end
    end
    function [handles] = makemathuna(color)
        for i = 1:length(isabr)
            isl = isabr(i);
            pos = islandpos(i,:);
            handles(i) = patch([(pos(1) - disx) pos(1) (pos(1) + disx) pos(1)],...
                [ pos(2) (pos(2) + disy) pos(2) (pos(2) - disy)], ...
                color);
            set(handles(i),'Visible','off');
        end
    end

%% I/O
    function updategamedata()
        gamedata(1) = {cell2mat(gamedata(1)) + 1}; % turn
        gamedata(2) = {cplayer}; % player
        gamedata(3) = {cround}; % round
        gamedata(4) = {toc};% time
        gamedata(5) = {getopencards()};
        gamedata(6) = {remainingcards()};
    end
    function updatepgamedata(player)
        pgamedata(player,1) = {gethandcards(player)}; %hands
        pgamedata(player,2) = {getbridges(player)};   %bridges
        pgamedata(player,3) = {getmathunas(player)};  %mathuna
    end
    function exportdata1()
        if (areweprinting)
            fprintf(fid,'%d\t%s\t%d\t%d\t%s\t%d',...
                cell2mat(gamedata(1)),cell2mat(Pnames(cell2mat(gamedata(2)))),...
                cell2mat(gamedata(3)),cell2mat(gamedata(4)),...
                cell2mat(gamedata(5)),cell2mat(gamedata(6)));
            fprintf(fid,'\t%s\t%s\t%s',...
                cell2mat(pgamedata(cell2mat(gamedata(2)),1)),...
                cell2mat(pgamedata(cell2mat(gamedata(2)),2)),...,
                cell2mat(pgamedata(cell2mat(gamedata(2)),3)));
        end
    end
    function exportdata2()
        if (length(lastactions) > 0)
            lastactions = lastactions(2:end); %% remove the first char
        end
        if(areweprinting)
            fprintf(fid,'\t%s',lastactions);
            fprintf(fid,'\t%s\t%s\t%s',...
                cell2mat(pgamedata(cell2mat(gamedata(2)),1)),...
                cell2mat(pgamedata(cell2mat(gamedata(2)),2)),...,
                cell2mat(pgamedata(cell2mat(gamedata(2)),3)));
            fprintf(fid,'\t%d',Pscore(cell2mat(gamedata(2))));
            fprintf(fid,'\n');
        end
    end
    function printheader()
        if(areweprinting)
            fprintf(fid,'turn\tplayer\tround\ttime\topencars\tndeckcards\thand_i\tbridges_i\tmathuna_i\tactions\thand_f\tbridges_f\tmathuna_f\tscore\n');
        end
    end
    function name = get_file_name()
        date = datestr(now,'dd-mm-yyyy_HH-MM-SS');
        mode = get(hmodemenu,'String');
        mode = mode(gamemode,:);
        if (gamemode == 1)
            mode = mode(1:4);
        end
        name = ['mathuna','_',mode,'_',date,'.tsv'];
    end

%% Other functions
    function changeplayer ()
        cplayer = otherplayer(cplayer);
    end
    function [p] = otherplayer(player)
        if (player == 1)
            p = 2;
        else
            p = 1;
        end
    end
    function [rdeck] = randomizedeck ()
        usedeck = deck;
        % when randomizedeck is called on rounds other than one,
        % we need to account for the cards that the players have in
        % their hands.
        playercards = [gethandcards(1),gethandcards(2)];
        if(not(strcmp(playercards,'')))
            for i = 1:length(playercards);
                for j = 1:length(usedeck)
                    if(strcmp(playercards(i),usedeck(j)))
                        usedeck = usedeck([1:(j-1),(j+1):end]);
                        break;
                    end
                end
            end
        end
        randindex = randperm(length(usedeck));
        rdeck = usedeck(randindex);
    end
    function [r] = remainingcards()
        r = length(cdeck) - cdeckcard + 1;
    end
    function [bool] = potentialdestroy (b,player)
        bool = 0;
        if (isfield(index,b))
            if (usedbridge(otherplayer(player),index.(b)) > 0)
                bool = 1;
            end
        end
    end
end
