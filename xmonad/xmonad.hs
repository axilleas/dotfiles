--
-- xmonad example config file.
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--
import List ( isPrefixOf )

import XMonad hiding ( (|||) )
import System.Exit

import System.IO
--import System.IO.UTF8
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.FadeInactive as FI
import XMonad.Hooks.UrgencyHook
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeysP, additionalKeys)
import XMonad.Layout.Grid
import XMonad.Layout.Named
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.DecorationMadness
import XMonad.Layout.TwoPane
import XMonad.Layout.Combo
import XMonad.Layout.Tabbed
--import XMonad.Layout.Reflect
--import XMonad.Layout.LayoutHints

-- U_quark's prompts
import XMonad.Prompt
import XMonad.Prompt.Window
import XMonad.Config.Desktop (desktopLayoutModifiers)
import XMonad.Layout.LayoutCombinators (JumpToLayout(..), (|||))

-- Fullscreen flash ('isFullscreen' function)
import XMonad.Hooks.ManageHelpers

-- For Eclipse JSwing and JApplet
import XMonad.Hooks.SetWMName

-- Scratchpad 
import XMonad.Util.Scratchpad

import qualified XMonad.StackSet as W
import qualified Data.Map        as M


-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "urxvtc"

-- Width of the window border in pixels.
--
myBorderWidth   = 1

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
--myModMask       = mod4Mask

-- The mask for the numlock key. Numlock status is "masked" from the
-- current modifier status, so the keybindings will work with numlock on or
-- off. You may need to change this on some systems.
--
-- You can find the numlock modifier by running "xmodmap" and looking for a
-- modifier with Num_Lock bound to it:
--
-- > $ xmodmap | grep Num
-- > mod2        Num_Lock (0x4d)
--
-- Set numlockMask = 0 if you don't have a numlock key, or want to treat
-- numlock status separately.
--
--myNumlockMask   = mod2Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces = ["1:code", "2:web", "3:fm", "4:im", 
						 "5:android", "6:arduino", "7fullscreen", "8terms", "9mail"]
    where miscs = map (("misc" ++) . show) . (flip take) [1..]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "black"
myFocusedBorderColor = "#FF66FF"
--myFocusedBorderColor = "#E56E94"

-- Default offset of drawable screen boundaries from each physical
-- screen. Anything non-zero here will leave a gap of that many pixels
-- on the given edge, on the that screen. A useful gap at top of screen
-- for a menu bar (e.g. 15)
--
-- An example, to set a top gap on monitor 1, and a gap on the bottom of
-- monitor 2, you'd use a list of geometries like so:
--
-- > defaultGaps = [(18,0,0,0),(0,18,0,0)] -- 2 gaps on 2 monitors
--
-- Fields are: top, bottom, left, right.
--
myDefaultGaps   = [(0,0,0,0)]

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $

    -- launch a terminal
    [ ((mod4Mask .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
--    , ((modMask,               xK_p     ), spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"")

    -- launch gmrun
    --  , ((modMask .|. shiftMask, xK_p     ), spawn "gmrun")

    -- close focused window 
    , ((mod4Mask .|. shiftMask, xK_c     ), kill)

     -- Rotate through the available layout algorithms
    , ((mod4Mask,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((mod4Mask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((mod4Mask,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((mod4Mask,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((mod4Mask,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((mod4Mask,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((mod4Mask,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((mod4Mask,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((mod4Mask .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((mod4Mask .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((mod4Mask,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((mod4Mask,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((mod4Mask,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((mod4Mask              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((mod4Mask              , xK_period), sendMessage (IncMasterN (-1)))

    -- toggle the status bar gap
    --, ((modMask              , xK_b     ),
    --     modifyGap (\i n -> let x = (XMonad.defaultGaps conf ++ repeat (0,0,0,0)) !! i
    --                         in if n == x then (0,0,0,0) else x))

    -- Quit xmonad
    , ((mod4Mask .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((mod4Mask              , xK_q     ), restart "xmonad" True)
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. mod4Mask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
    ++

    --
    -- my Additional Keybindings
    --
    [ ((mod4Mask             , xK_f     ), spawn "/usr/bin/firefox")
    , ((mod4Mask             , xK_b     ), spawn "/usr/bin/firefox-beta-bin")
    , ((mod4Mask             , xK_p     ), spawn "pidgin")
    , ((mod4Mask             , xK_g     ), spawn "geany")
    , ((mod4Mask             , xK_t     ), spawn "thunar")
    , ((mod4Mask             , xK_a     ), spawn "arduino")
    , ((mod4Mask             , xK_Print ), spawn  "scrot -e 'mv $f ~/Pictures/'")
--    , ((0                    , xK_grave ), scratchpadSpawnActionTerminal "urxvtc")
    -- Scratchpad
    , ((0            				 , xK_grave ), scratchpadSpawnActionTerminal myTerminal)]
    -- GO to Urgent workspace
--  , ((modMask             , xK_y     ), focusUrgent )]

--u_quark's layout prompt KeyBinding
extraKB = [("M-C-<Space>",   layoutPrompt myXPConfig)]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modMask, button1), (\w -> focus w >> mouseMoveWindow w))

    -- mod-button2, Raise the window to the top of the stack
    , ((modMask, button2), (\w -> focus w >> windows W.swapMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modMask, button3), (\w -> focus w >> mouseResizeWindow w))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--

-- default tiling algorithm partitions the screen into two panes
basicLayout = Tall nmaster delta ratio where
    -- The default number of windows in the master pane
    nmaster = 1
    -- Percent of screen to increment by when resizing panes
    delta   = 3/100
    -- Default proportion of screen occupied by master pane
    ratio   = 1/2
tallLayout = named "tall" $ avoidStruts $ basicLayout
wideLayout = named "wide" $ avoidStruts $ Mirror basicLayout
singleLayout = named "single" $ avoidStruts $ noBorders Full
circleLayout = named "circle" $ avoidStruts $ circleSimpleDefaultResizable
fullscreenLayout = named "fullscreen" $ noBorders Full

-- special layout on certain workspaces
myLayout =  fullscreen $ circle $ normal  where
    normal     = tallLayout ||| wideLayout ||| singleLayout ||| circleLayout ||| tabbed_one ||| tabbed_two 
    fullscreen = onWorkspace "7:fullscreen" fullscreenLayout
    circle = onWorkspace "8:terms" circleLayout
    tabbed_one = named "tabbed" $ tabbed  shrinkText defaultTheme
    tabbed_two = named "two tabbed" $  combineTwo (TwoPane 0.03 0.5) tabbed_one tabbed_one

-- Set up the Layout prompt
data Prompt = Prompt String

instance XPrompt Prompt where
    showXPrompt (Prompt x) = x

allLayouts = ["tall", "wide", "single", "circle", "fullscreen", "tabbed", "two tabbed"]

layoutPrompt :: XPConfig -> X ()
layoutPrompt c = mkXPrompt (Prompt "Layout: ") c (mkComplFunFromList' allLayouts) (sendMessage . JumpToLayout)

myXPConfig = defaultXPConfig {
    fgColor = myInactiveTextColor,
    bgColor = myInactiveColor,
    fgHLight = myActiveTextColor,
    bgHLight = myActiveColor,
    borderColor = myInactiveBorderColor,
    font = myFont
}
-- Theme (only for Prompts)
myActiveColor = "#99F9FF"
myInactiveColor = "#EBF4F5"
myUrgentColor = "#FF9999"
myActiveBorderColor = "#001964"
myInactiveBorderColor = "#001964"
myUrgentBorderColor = "#001964"
myActiveTextColor = "#001964"
myInactiveTextColor = "#001964"
myUrgentTextColor = "#001964"
myFontName size = "xft:monospace:pixelsize=" ++ show size ++ ":autohinting=true:antialias=true"
myFont = myFontName 11


------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = scratchpadManageHookDefault <+> manageDocks 
               <+> fullscreenManageHook <+> myFloatHook 
               <+> manageHook defaultConfig
myFloatHook = composeAll
    [ className =? "GIMP"  --> doFloat
    , className =? "feh"  --> doFloat 
    , className =? "Firefox" --> moveToWeb
    , resource =? "firefox" --> moveToWeb
    , className =? "MPlayer" --> moveToFull
    , resource =? "eclipse" --> moveToCode
    , className =? "Pidgin" --> moveToIM
    , resource =? "pidgin" --> moveToIM
    , className =? "Skype" --> moveToIM
    , resource =? "skype" --> moveToIM
    , className =? "Thunar" --> moveToFileManager
    , resource =? "thunar" --> moveToFileManager
    , manageDocks] where
        moveToIM = doF $ W.shift "4:im"
        moveToWeb = doF $ W.shift "2:web"
        moveToFull = doF $ W.shift "7:fullscreen"
        moveToCode = doF $ W.shift "1:code"
        moveToFileManager = doF $ W.shift "3:fm"
fullscreenManageHook = composeOne [ isFullscreen -?> doFullFloat ]
-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True


------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = return ()

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'DynamicLog' extension for examples.
--
-- To emulate dwm's status bar
--
-- > logHook = dynamicLogDzen
--
--myLogHook = (dynamicLogWithPP $ xmobarPP {
--    ppOutput = System.IO.UTF8.hPutStrLn xmproc,
--    ppTitle = xmobarColor "green" "". shorten 50
--}) >> fadeInactiveLogHook 0xbbbbbbbb

--myLogHook = return ()
--
myLogHook :: X ()
myLogHook = fadeInactiveLogHook fadeAmount
    where fadeAmount = 0.8

-- Copy of xmobarStrip from darcs version of DynamicLog.hs
-- http://code.haskell.org/XMonadContrib/XMonad/Hooks/DynamicLog.hs.
xmobarStrip :: String -> String
xmobarStrip = strip [] where
  strip keep x
    | null x = keep
    | "<fc=" `isPrefixOf` x = strip keep (drop 1 . dropWhile (/= '>') $ x)
    | "</fc>" `isPrefixOf` x = strip keep (drop 5 x)
    | '<' == head x = strip (keep ++ "<") (tail x)
    | otherwise = let (good, x') = span (/= '<') x in strip (keep ++ good) x'

------------------------------------------------------------------------
-- Default Config
-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will 
-- use the defaults defined in xmonad/XMonad/Config.hs
-- 
-- No need to modify this.
--
defaults = defaultConfig {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        --mod4Mask            = myModMask,
        --numlockMask        = myNumlockMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,
        --defaultGaps        = myDefaultGaps,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        logHook            = myLogHook,
        -- For JSwing and JApplet (Eclipse)
        startupHook        = myStartupHook >> setWMName "LG3D"
    }

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = do
	spawnPipe "trayer --edge top --align right --SetDockType true --width 6 --transparent true --height 6 --SetPartialStrut true --tint 000000"
    --spawnPipe "eval `ssh-agent`"
    --spawnPipe "gnome-power-manager"
    --spawnPipe "feh --bg-center pictures/wallpaper_gnu.jpg"
	xmproc <- spawnPipe "`which xmobar` $HOME/.xmonad/xmobar"
	xmonad $ withUrgencyHook NoUrgencyHook $ defaults {
            logHook   = do FI.fadeInactiveLogHook 0xbbbbbbbb
                           dynamicLogWithPP $ xmobarPP {
                              ppOutput = hPutStrLn xmproc
                            , ppTitle = xmobarColor "#ff66ff" "" . shorten 50  
                            , ppUrgent = xmobarColor "yellow" "red" . Main.xmobarStrip
                           }
            } 
			`additionalKeysP` extraKB
