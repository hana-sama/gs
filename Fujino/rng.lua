-- Original: Motenten / Modified: Arislan
-- Haste/DW Detection Requires Gearinfo Addon

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Modes
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ ALT+F9 ]          Cycle Ranged Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--  Abilities:  [ CTRL+NumLock ]    Double Shot
--              [ CTRL+Numpad/ ]    Berserk/Meditate
--              [ CTRL+Numpad* ]    Warcry/Sekkanoki
--              [ CTRL+Numpad- ]    Aggressor/Third Eye
--
--  Spells:     [ WIN+, ]           Utsusemi: Ichi
--              [ WIN+. ]           Utsusemi: Ni
--
--  Weapons:    [ WIN+E/R ]         Cycles between available Weapon Sets
--
--  WS:         [ CTRL+Numpad7 ]    Trueflight
--              [ CTRL+Numpad8 ]    Last Stand
--              [ CTRL+Numpad4 ]    Wildfire
--
--  RA:         [ Numpad0 ]         Ranged Attack
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
  set_language('japanese')

  mote_include_version = 2
  -- Load and initialize the include file.
  include('Mote-Include.lua')

  include('mystyle')
  include('myexport')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
  state.Buff.Barrage = buffactive.Barrage or false
  state.Buff.Camouflage = buffactive.Camouflage or false
  state.Buff['エンドレスショット'] = buffactive['エンドレスショット'] or false
  state.Buff['ベロシティショット'] = buffactive['ベロシティショット'] or false
  state.Buff['ダブルショット'] = buffactive['ダブルショット'] or false

  -- Whether a warning has been given for low ammo
  state.warned = M(false)

  elemental_ws = S{'イオリアンエッジ', 'トゥルーフライト', 'ワイルドファイア'}
  no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
            "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring",
            "Era. Bul. Pouch", "Dev. Bul. Pouch", "Chr. Bul. Pouch", "Quelling B. Quiver",
            "Yoichi's Quiver", "Artemis's Quiver", "Chrono Quiver"}

  lockstyleset = 1
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
  state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc', 'STP')
  state.HybridMode:options('Normal', 'DT')
  state.RangedMode:options('STP', 'Normal', 'Acc', 'HighAcc', 'Critical')
  state.WeaponskillMode:options('Normal', 'Acc', 'Enmity')
  state.IdleMode:options('Normal', 'DT')

  state.WeaponSet = M{['description']='Weapon Set', 'Annihilator', 'Fomalhaut', 'Armageddon'}
  -- state.CP = M(false, "Capacity Points Mode")

  DefaultAmmo = {['与一の弓'] = "クロノアロー",
                 ['ガーンデーヴァ'] = "クロノアロー",
                 ['アキヌフォート'] = "クロノアロー",
                 ['アナイアレイター'] = "クロノブレット",
                 ['アルマゲドン'] = "クロノブレット",
                 ['ガストラフェテス'] = "クェリングボルト",
                 ['フォーマルハウト'] = "クロノブレット",
                 }

  AccAmmo = {    ['与一の弓'] = "与一の矢",
                 ['ガーンデーヴァ'] = "与一の矢",
                 ['アキヌフォート'] = "与一の矢",
                 ['アナイアレイター'] = "エラデケトブレット",
                 ['アルマゲドン'] = "エラデケトブレット",
                 ['ガストラフェテス'] = "クェリングボルト",
                 ['フォーマルハウト'] = "デベステトブレット",
                 }

  WSAmmo = {     ['与一の弓'] = "クロノアロー",
                 ['ガーンデーヴァ'] = "クロノアロー",
                 ['アキヌフォート'] = "クロノアロー",
                 ['アナイアレイター'] = "クロノブレット",
                 ['アルマゲドン'] = "クロノブレット",
                 ['ガストラフェテス'] = "クェリングボルト",
                 ['フォーマルハウト'] = "クロノブレット",
                 }

  MagicAmmo = {  ['与一の弓'] = "クロノアロー",
                 ['ガーンデーヴァ'] = "クロノアロー",
                 ['アキヌフォート'] = "クロノアロー",
                 ['アナイアレイター'] = "デベステトブレット",
                 ['アルマゲドン'] = "デベステトブレット",
                 ['ガストラフェテス'] = "クェリングボルト",
                 ['フォーマルハウト'] = "デベステトブレット",
                 }

  -- Additional local binds
  --include('Global-Binds.lua') -- OK to remove this line
  --include('Global-GEO-Binds.lua') -- OK to remove this line

  send_command('bind ^` input /ja '..windower.to_shift_jis("ベロシティショット")..' <me>')
  send_command ('bind @` input /ja '..windower.to_shift_jis("スカベンジ")..' <me>')

  if player.sub_job == 'DNC' then
      send_command('bind ^, input /ja '..windower.to_shift_jis("スペクトラルジグ")..' <me>')
      send_command('unbind ^.')
  else
      send_command('bind ^, input /item '..windower.to_shift_jis("サイレントオイル")..' <me>')
      send_command('bind ^. input /item '..windower.to_shift_jis("プリズムパウダー")..' <me>')
  end

  -- send_command('bind @c gs c toggle CP')
  send_command('bind @e gs c cycleback WeaponSet')
  send_command('bind @r gs c cycle WeaponSet')

  send_command('bind ^numlock input /ja '..windower.to_shift_jis("ダブルショット")..' <me>')

  if player.sub_job == 'WAR' then
      send_command('bind ^numpad/ input /ja '..windower.to_shift_jis("バーサク")..' <me>')
      send_command('bind ^numpad* input /ja '..windower.to_shift_jis("ウォークライ")..' <me>')
      send_command('bind ^numpad- input /ja '..windower.to_shift_jis("アグレッサー")..' <me>')
  elseif player.sub_job == 'SAM' then
      send_command('bind ^numpad/ input /ja '..windower.to_shift_jis("黙想")..' <me>')
      send_command('bind ^numpad* input /ja '..windower.to_shift_jis("石火之機")..' <me>')
      send_command('bind ^numpad- input /ja '..windower.to_shift_jis("心眼")..' <me>')
  end

  send_command('bind ^numpad7 input /ws '..windower.to_shift_jis("トゥルーフライト")..' <t>')
  send_command('bind ^numpad8 input /ws '..windower.to_shift_jis("ラストスタンド")..' <t>')
  send_command('bind ^numpad4 input /ws '..windower.to_shift_jis("ワイルドファイア")..' <t>')
  send_command('bind ^numpad6 input /ws '..windower.to_shift_jis("カラナック")..' <t>')
  send_command('bind ^numpad2 input /ws '..windower.to_shift_jis("スナイパーショット")..' <t>')
  send_command('bind ^numpad3 input /ws '..windower.to_shift_jis("ナビングショット")..' <t>')

  send_command('bind numpad0 input /ra <t>')

  select_default_macro_book()
  set_lockstyle()

  state.Auto_Kite = M(false, 'Auto_Kite')
  Haste = 0
  DW_needed = 0
  DW = false
  moving = false
  update_combat_form()
  determine_haste_group()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
  send_command('unbind f9')
  send_command('unbind ^f9')
  send_command('unbind ^`')
  send_command('unbind !`')
  send_command('unbind @`')
  send_command('unbind ^,')
  send_command('unbind @f')
  -- send_command('unbind @c')
  send_command('unbind @e')
  send_command('unbind @r')
  send_command('unbind ^numlock')
  send_command('unbind ^numpad/')
  send_command('unbind ^numpad*')
  send_command('unbind ^numpad-')
  send_command('unbind ^numpad7')
  send_command('unbind ^numpad8')
  send_command('unbind ^numpad4')
  send_command('unbind ^numpad6')
  send_command('unbind ^numpad2')
  send_command('unbind ^numpad3')
  send_command('unbind numpad0')

  send_command('unbind #`')
  send_command('unbind #1')
  send_command('unbind #2')
  send_command('unbind #3')
  send_command('unbind #4')
  send_command('unbind #5')
  send_command('unbind #6')
  send_command('unbind #7')
  send_command('unbind #8')
  send_command('unbind #9')
  send_command('unbind #0')
end


-- Set up all gear sets.
function init_gear_sets()

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Precast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Precast sets to enhance JAs
  sets.precast.JA['イーグルアイ'] = {legs="ＡＲブラッカエ+3"}
  sets.precast.JA['バウンティショット'] = {hands="ＡＭグロブレト+1"}
  sets.precast.JA['カモフラージュ'] = {body="ＯＲジャーキン+3"}
  sets.precast.JA['スカベンジ'] = {feet="ＯＲソックス+1"}
  sets.precast.JA['影縫い'] = {hands="ＯＲブラッカエ+3"}
  sets.precast.JA['狙い撃ち'] = {legs="ＯＲブラッカエ+3"}


  -- Fast cast sets for spells

  sets.precast.Waltz = {
      body="パションジャケット",
      --ring1="Asklepian Ring",
      waist="ギシドゥバサッシュ",
      }

  sets.precast.Waltz['ヒーリングワルツ'] = {}

  sets.precast.FC = {
      head="カマインマスク+1", --14
      body=gear.Taeon_FC_body, --9
      hands="レイライングローブ", --8
      legs="ローハイドトラウザ", --5
      feet="カマイングリーヴ+1", --8
      neck="オルンミラトルク", --5
      ear1="ロケイシャスピアス", --2
      ear2="エンチャンピアス+1", --2
      --ring1="Weather. Ring +1", --6(4)
      waist="ルミネートサッシュ",
      }

  sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
      body="パションジャケット",
      ring2="レベッチェリング",
      })


  -- (10% Snapshot, 5% Rapid from Merits)
  sets.precast.RA = {
      head=gear.Taeon_RA_head, --10/0
      body="ＡＭカバン+1",
      hands="Carmine Fin. Ga. +1", --8/11
      legs="ＯＲブラッカエ+3", --15/0
      feet="メガナダジャンボ+2", --10/0
      neck="スカウトゴルゲット+2", --4/0
      back=gear.RNG_SNP_Cape, --10/0
      waist="インパルスベルト", --3/0
      } --60/11

  sets.precast.RA.Flurry1 = set_combine(sets.precast.RA, {
      head="ＯＲベレー+3", --0/18
      legs=gear.Adhemar_D_legs, --10/13
      }) --45/42

  sets.precast.RA.Flurry2 = set_combine(sets.precast.RA.Flurry1, {
      feet="オショシレギンス+1", --0/10
      waist="オショシレギンス", --0/5
      }) --32/57

  --[[
  sets.precast.RA.Gastra = {
      head="Orion Beret +3", --15/0
      }

  sets.precast.RA.Gastra.Flurry1 = set_combine(sets.precast.RA.Gastra, {
      feet="Arcadian Socks +3", --0/10
      })

  sets.precast.RA.Gastra.Flurry2 = set_combine(sets.precast.RA.Gastra.Flurry1, {
      legs="Pursuer's Pants", --0/19
      })
  ]]--


  ------------------------------------------------------------------------------------------------
  ------------------------------------- Weapon Skill Sets ----------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.precast.WS = {
      head="ＯＲベレー+3",
      body=gear.Herc_RA_body,
      hands="メガナダグローブ+2",
      legs="ＡＲブラッカエ+3",
      feet=gear.Herc_WSD_feet,
      neck="フォシャゴルゲット",
      ear1="イシュヴァラピアス",
      ear2="胡蝶のイヤリング",
      ring1="Regal Ring",
      ring2="エパミノダスリング",
      back=gear.RNG_WS2_Cape,
      waist="フォシャベルト",
      }

  sets.precast.WS.Acc = set_combine(sets.precast.WS, {
      --feet="Arcadian Socks +3",
      ear1="ベイラピアス",
      waist="カフカチナベルト+1",
      })

  sets.precast.WS.Enmity = set_combine(sets.precast.WS, {
      --hands="Arc. Brac+3",
      --feet="Arcadian Socks +3",
      ear1="ベイラピアス",
      })

  sets.precast.WS['エイペクスアロー'] = sets.precast.WS

  sets.precast.WS['エイペクスアロー'].Acc = set_combine(sets.precast.WS['エイペクスアロー'], {
      feet="Orion Socks +3",
      ear1="ベイラピアス",
      waist="カフカチナベルト+1",
      })

  sets.precast.WS['エイペクスアロー'].Enmity = set_combine(sets.precast.WS['エイペクスアロー'], {
      hands="Arc. Bracers +3",
      feet="Arcadian Socks +3",
      ear1="Beyla Earring",
      })

  sets.precast.WS['ジシュヌの光輝'] = set_combine(sets.precast.WS, {
      head="Mummu Bonnet +2",
      body="Abnoba Kaftan",
      hands="Mummu Wrists +2",
      feet="Thereoid Greaves",
      ear1="Sherida Earring",
      ring1="Begrudging Ring",
      ring2="Mummu Ring",
      })

  sets.precast.WS['ジシュヌの光輝'].Acc = set_combine(sets.precast.WS['ジシュヌの光輝'], {
      legs="Mummu Kecks +2",
      feet="Arcadian Socks +3",
      neck="Iskur Gorget",
      ear1="Beyla Earring",
      ear2="Telos Earring",
      ring1="Regal Ring",
      ring2="Hajduk Ring +1",
      waist="K. Kachina Belt +1",
      })

  sets.precast.WS['ジシュヌの光輝'].Enmity = set_combine(sets.precast.WS['ジシュヌの光輝'], {
      hands="Arc. Bracers +3",
      feet="Arcadian Socks +3",
      ear1="Beyla Earring",
      })

  sets.precast.WS["ラストスタンド"] = set_combine(sets.precast.WS, {
      neck="Scout's Gorget +2",
      })

  sets.precast.WS['ラストスタンド'].Acc = set_combine(sets.precast.WS['ラストスタンド'], {
      ammo=gear.ACCbullet,
      feet="Orion Socks +3",
      ear1="Beyla Earring",
      ear2="Telos Earring",
      ring2="Hajduk Ring +1",
      waist="K. Kachina Belt +1",
      })

  sets.precast.WS['ラストスタンド'].Enmity = set_combine(sets.precast.WS['ラストスタンド'], {
      hands="Arc. Bracers +3",
      feet="Arcadian Socks +3",
      ear1="Beyla Earring",
      })

  sets.precast.WS["カラナック"] = set_combine(sets.precast.WS['ラストスタンド'], {
      neck="Scout's Gorget +2",
      ear1="Sherida Earring",
      ear2="Mache Earring +1",
      })

  sets.precast.WS["カラナック"].Acc = set_combine(sets.precast.WS['カラナック'], {
      ear1="Beyla Earring",
      ear2="Telos Earring",
      })

  sets.precast.WS["カラナック"].Enmity = set_combine(sets.precast.WS['カラナック'], {
      ear1="Beyla Earring",
      })

  sets.precast.WS["トゥルーフライト"] = {
      head="Orion Beret +3",
      body="Carm. Sc. Mail +1",
      hands="Carmine Fin. Ga. +1",
      legs=gear.Herc_WSD_legs,
      feet=gear.Herc_WSD_feet,
      neck="Scout's Gorget +2",
      ear1="Moonshade Earring",
      ear2="Friomisi Earring",
      ring1="Weather. Ring +1",
      ring2="Epaminondas's Ring",
      back=gear.RNG_WS1_Cape,
      waist="Eschan Stone",
      }

  sets.precast.WS["ワイルドファイア"] = set_combine(sets.precast.WS["トゥルーフライト"], {
      ring1="Regal Ring",
      waist="Skrymir Cord +1",
      })

  sets.precast.WS['エヴィサレーション'] = {
      head=gear.Adhemar_B_head,
      body="Abnoba Kaftan",
      hands="Mummu Wrists +2",
      legs="Zoar Subligar +1",
      neck="Fotia Gorget",
      ear2="Mache Earring +1",
      ring1="Begrudging Ring",
      ring2="Mummu Ring",
      back=gear.RNG_TP_Cape,
      waist="Fotia Belt",
      }

  sets.precast.WS['エヴィサレーション'].Acc = set_combine(sets.precast.WS['エヴィサレーション'], {
      head="Dampening Tam",
      body=gear.Adhemar_B_body,
      legs=gear.Herc_WS_legs,
      ring1="Regal Ring",
      })

  sets.precast.WS['Rampage'] = set_combine(sets.precast.WS['エヴィサレーション'], {feet=gear.Herc_TA_feet})
  sets.precast.WS['Rampage'].Acc = sets.precast.WS['エヴィサレーション'].Acc


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Midcast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Fast recast for spells

  sets.midcast.FastRecast = sets.precast.FC

  sets.midcast.SpellInterrupt = {
      body=gear.Taeon_Phalanx_body, --10
      hands="Rawhide Gloves", --15
      legs="Carmine Cuisses +1", --20
      feet=gear.Taeon_Phalanx_feet, --10
      neck="Loricate Torque +1", --5
      ear1="Halasz Earring", --5
      ear2="Magnetic Earring", --8
      ring2="Evanescence Ring", --5
      waist="Rumination Sash", --10
      }

  sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

  -- Ranged sets

  sets.midcast.RA = {
      head="Arcadian Beret +3",
      body="Malignance Tabard",
      hands="Malignance Gloves",
      legs="Malignance Tights",
      feet="Malignance Boots",
      neck="Scout's Gorget +2",
      ear1="Enervating Earring",
      ear2="Telos Earring",
      ring1="Regal Ring",
      ring2="Dingir Ring",
      back=gear.RNG_RA_Cape,
      waist="Yemaya Belt",
      }

  sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {
      feet="Orion Socks +3",
      ear1="Beyla Earring",
      ring2="Hajduk Ring +1",
      })

  sets.midcast.RA.HighAcc = set_combine(sets.midcast.RA.Acc, {
      head="Orion Beret +3",
      body="Orion Jerkin +3",
      hands="Orion Bracers +3",
      waist="K. Kachina Belt +1",
      })

  sets.midcast.RA.Critical = set_combine(sets.midcast.RA, {
      head="Meghanada Visor +2",
      body="Mummu Jacket +2",
      hands="Kobo Kote",
      legs="Mummu Kecks +2",
      feet="Osh. Leggings +1",
      ring1="Begrudging Ring",
      ring2="Mummu Ring",
      waist="K. Kachina Belt +1",
      })

  sets.midcast.RA.STP = set_combine(sets.midcast.RA, {
      neck="Iskur Gorget",
      ear1="Dedition Earring",
      ring1={name="Chirich Ring +1", bag="wardrobe3"},
      ring2={name="Chirich Ring +1", bag="wardrobe4"},
      })

  sets.DoubleShot = {
      head="Arcadian Beret +3",
      body="Arc. Jerkin +3",
      hands="Oshosi Gloves +1", -- 5
      legs="Osh. Trousers +1", --7
      feet="Osh. Leggings +1", --4
      } --25

  sets.DoubleShot.Critical = {
      head="Meghanada Visor +2",
      waist="K. Kachina Belt +1",
      }

  sets.TrueShot = {
      body="Nisroch Jerkin",
      legs="Osh. Trousers +1",
      }


  ------------------------------------------------------------------------------------------------
  ----------------------------------------- Idle Sets --------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.resting = {}

  -- Idle sets
  sets.idle = {
      head="マリグナスシャポー",
      body="マリグナスタバード",
      hands="マリグナスグローブ",
      legs="マリグナスタイツ",
      feet="マリグナスブーツ",
      neck="スカウトゴルゲット+2",
      neck="バーシチョーカー+1",
      ear1="驕慢の耳",
      ear2="エアバニピアス",
      ring1={name="シーリチリング+1", bag="wardrobe7"},
      ring2={name="シーリチリング+1", bag="wardrobe8"},
      back="月光の羽衣",
      waist="キャリアーサッシュ",
      }

  sets.idle.DT = set_combine(sets.idle, {
      head="マリグナスシャポー",
      body="マリグナスタバード",
      hands="マリグナスグローブ",
      legs="マリグナスタイツ",
      feet="マリグナスブーツ",
      neck="ウォーダチャーム+1",
      --ring1="Purity Ring", --0/4
      ring2="守りの指輪", --10/10
      back="月光の羽衣", --6/6
      })

  sets.idle.Town = set_combine(sets.idle, {
      head="ＯＲベレー+3",
      body="オショシベスト+1",
      hands="オショシグローブ+1",
      legs="ＡＲブラッカエ+3",
      feet="オショシレギンス+1",
      neck="スカウトゴルゲット+2",
      ear1="ベイラピアス",
      ear2="テロスピアス",
      back=gear.RNG_RA_Cape,
      waist="カフカチナベルト+1",
      })


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Defense Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.defense.PDT = sets.idle.DT
  sets.defense.MDT = sets.idle.DT

  sets.Kiting = {feet="ＯＲソックス+3"}


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Engaged Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Engaged sets

  -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
  -- sets if more refined versions aren't defined.
  -- If you create a set with both offense and defense modes, the offense mode should be first.
  -- EG: sets.engaged.Dagger.Accuracy.Evasion

  sets.engaged = {
      head={ name="アデマボンネット+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
      body={ name="アデマジャケット+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
      hands={ name="アデマリスト+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
      --legs="サムヌータイツ",
      --feet=gear.Herc_TA_feet,
      legs="マリグナスタイツ",
      feet="マリグナスブーツ",
      neck="スカウトゴルゲ+2",
      ear1="素破の耳",
      ear2="シェリダピアス",
      ring1={name="シーリチリング+1", bag="wardrobe7"},
      ring2="エポナリング",
      back=gear.RNG_TP_Cape,
      waist="ウィンバフベルト+1",
      }

  sets.engaged.LowAcc = set_combine(sets.engaged, {
      head="マリグナスシャポー",
      --hands=gear.Adhemar_A_hands,
      hands={ name="アデマリスト+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
      --neck="Combatant's Torque",
      neck="スカウトゴルゲ+2",
      ring1={name="シーリチリング+1", bag="wardrobe7"},
     })

  sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
      ear2="テロスピアス",
      ring1="Regal Ring",
      ring2="イラブラットリング",
      waist="ケンタークベルト+1",
      })

  sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
      head="カマインマスク+1",
      hands="ガズブレスレット+1",
      ear1="セサンスピアス",
      ear2="マーケピアス+1",
      ring2={name="シーリチリング+1", bag="wardrobe8"},
      waist="オルセニベルト",
      })

  sets.engaged.STP = set_combine(sets.engaged, {
      head=gear.Herc_STP_head,
      feet="カマイングリーブ+1",
      ring1={name="シーリチリング+1", bag="wardrobe7"},
      ring2={name="シーリチリング+1", bag="wardrobe8"},
      })

  -- * DNC Subjob DW Trait: +15%
  -- * NIN Subjob DW Trait: +25%

  -- No Magic Haste (74% DW to cap)
  sets.engaged.DW = {
      head={ name="アデマボンネット+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
      body={ name="アデマジャケット+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
      --hands="フローラルガントレ", --5
      hands={ name="アデマリスト+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
      --legs="カマインクウィス+1", --6
      --feet=gear.Taeon_DW_feet, --9
      legs="マリグナスタイツ",
      feet="マリグナスブーツ",
      --neck="イスクルゴルゲット",
      neck="スカウトゴルゲ+2",
      ear1="素破の耳", --5
      ear2="エアバニピアス", --4
      ring1="ヘタイロイリング",
      ring2="エポナリング",
      back=gear.RNG_DW_Cape, --10
      waist="霊亀腰帯", --7
      } -- 52%

  sets.engaged.DW.LowAcc = set_combine(sets.engaged.DW, {
      head="マリグナスシャポー",
      ring1={name="シーリチリング+1", bag="wardrobe7"},
      })

  sets.engaged.DW.MidAcc = set_combine(sets.engaged.DW.LowAcc, {
      hands=gear.Adhemar_A_hands,
      --neck="Combatant's Torque",
      neck="スカウトゴルゲ+2",
      ring2="イラブラットリング",
      waist="ケンタークベルト+1",
      })

  sets.engaged.DW.HighAcc = set_combine(sets.engaged.DW.MidAcc, {
      head="カマインマスク+1",
      hands="ガズブレスレット+1",
      ear1="セサンスピアス",
      ear2="マーケピアス+1",
      ring1="Regal Ring",
      ring2={name="シーリチリング+1", bag="wardrobe8"},
      waist="オルセニベルト",
      })

  sets.engaged.DW.STP = set_combine(sets.engaged.DW, {
      head=gear.Herc_STP_head,
      ring1={name="シーリチリング+1", bag="wardrobe7"},
      ring2={name="シーリチリング+1", bag="wardrobe8"},
      })

  -- 15% Magic Haste (67% DW to cap)
  sets.engaged.DW.LowHaste = {
      --head=gear.Adhemar_B_head,
      --body=gear.Adhemar_B_body, --6
      head={ name="アデマボンネット+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
      body={ name="アデマジャケット+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
      --hands="Floral Gauntlets", --5
      hands={ name="アデマリスト+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
      --legs="Carmine Cuisses +1", --6
      --feet=gear.Taeon_DW_feet, --9
      legs="マリグナスタイツ",
      feet="マリグナスブーツ",
      --neck="Iskur Gorget",
      neck="スカウトゴルゲ+2",
      ear1="素破の耳", --5
      ear2="エアバニピアス", --4
      ring1="ヘタイロイリング",
      ring2="エポナリング",
      back=gear.RNG_TP_Cape,
      waist="霊亀腰帯",
      } -- 42%

  sets.engaged.DW.LowAcc.LowHaste = set_combine(sets.engaged.DW.LowHaste, {
      --head="Dampening Tam",
      --neck="Combatant's Torque",
      head="マリグナスシャポー",
      ring1={name="シーリチリング+1", bag="wardrobe7"},
      })

  sets.engaged.DW.MidAcc.LowHaste = set_combine(sets.engaged.DW.LowAcc.LowHaste, {
      --hands=gear.Adhemar_A_hands,
      hands={ name="アデマリスト+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
      ear2="テロスピアス",
      ring2="イラブラットリング",
      waist="ケンタークベルト+1",
      })

  sets.engaged.DW.HighAcc.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, {
      head="カマインマスク+1",
      hands="ガズブレスレット+1",
      ear1="セサンスピアス",
      ear2="マーケピアス+1",
      ring1="Regal Ring",
      ring2={name="シーリチリング+1", bag="wardrobe8"},
      waist="オルセニベルト",
      })

  sets.engaged.DW.STP.LowHaste = set_combine(sets.engaged.DW.LowHaste, {
      head=gear.Herc_STP_head,
      ring1={name="シーリチリング+1", bag="wardrobe7"},
      ring2={name="シーリチリング+1", bag="wardrobe8"},
      })

  -- 30% Magic Haste (56% DW to cap)
  sets.engaged.DW.MidHaste = {
      --head=gear.Adhemar_B_head,
      --body=gear.Adhemar_B_body, --6
      --hands=gear.Adhemar_B_hands,
      head={ name="アデマボンネット+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
      body={ name="アデマジャケット+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
      hands={ name="アデマリスト+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
      legs="マリグナスタイツ",
      feet="マリグナスブーツ", --9
      neck="スカウトゴルゲ+2",
      ear1="素破の耳", --5
      ear2="エアバニピアス", --4
      ring1="ヘタイロイリング",
      ring2="エポナリング",
      back=gear.RNG_TP_Cape,
      waist="霊亀腰帯", --7
    } -- 31%

  sets.engaged.DW.LowAcc.MidHaste = set_combine(sets.engaged.DW.MidHaste, {
      head="マリグナスシャポー",
      --hands=gear.Adhemar_A_hands,
      hands={ name="アデマリスト+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
      neck="スカウトゴルゲ+2",
      ring1={name="シーリチリング+1", bag="wardrobe7"},
      })

  sets.engaged.DW.MidAcc.MidHaste = set_combine(sets.engaged.DW.LowAcc.MidHaste, {
      legs="メガナダショウス+2",
      ear2="テロスピアス",
      ring2="イラブラットリング",
      waist="ケンタークベルト+1",
      })

  sets.engaged.DW.HighAcc.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, {
      head="カマインマスク+1",
      hands="ガズブレスレット+1",
      legs="カマインクウィス+1",
      ear1="セサンスピアス",
      ear2="マーケピアス+1",
      ring1="Regal Ring",
      ring2={name="シーリチリング+1", bag="wardrobe8"},
      waist="オルセニベルト",
      })

  sets.engaged.DW.STP.MidHaste = set_combine(sets.engaged.DW.MidHaste, {
      head=gear.Herc_STP_head,
      ring1={name="シーリチリング+1", bag="wardrobe7"},
      ring2={name="シーリチリング+1", bag="wardrobe8"},
      })

  -- 35% Magic Haste (51% DW to cap)
  sets.engaged.DW.HighHaste = {
      --head=gear.Adhemar_B_head,
      --body=gear.Adhemar_B_body, --6
      --hands=gear.Adhemar_B_hands,
      head={ name="アデマボンネット+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
      body={ name="アデマジャケット+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
      hands={ name="アデマリスト+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
      legs={ name="サムヌータイツ", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
      --legs="Samnuha Tights",
      --feet=gear.Herc_TA_feet,
      feet="マリグナスブーツ",
      neck="イスクルゴルゲット",
      ear1="素破の耳", --5
      ear2="エアバニピアス", --4
      ring1="ヘタイロイリング",
      ring2="エポナリング",
      back=gear.RNG_TP_Cape,
      waist="霊亀腰帯", --7
    } -- 27%

  sets.engaged.DW.LowAcc.HighHaste = set_combine(sets.engaged.DW.HighHaste, {
      --head="Dampening Tam",
      head="マリグナスシャポー",
      --hands=gear.Adhemar_A_hands,
      hands={ name="アデマリスト+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
      --neck="Combatant's Torque",
      neck="スカウトゴルゲ+2",
      ring1={name="シーリチリング+1", bag="wardrobe7"},
      })

  sets.engaged.DW.MidAcc.HighHaste = set_combine(sets.engaged.DW.LowAcc.HighHaste, {
      legs="メガナダショウス+2",
      ear2="テロスピアス",
      ring2="イラブラットリング",
      waist="ケンタークベルト+1",
      })

  sets.engaged.DW.HighAcc.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, {
      head="カマインマスク+1",
      hands="ガズブレスレット+1",
      legs="カマインクウィス+1",
      ear1="セサンスピアス",
      ear2="マーケピアス+1",
      ring1="Regal Ring",
      ring2={name="シーリチリング+1", bag="wardrobe8"},
      waist="オルセニベルト",
      })

  sets.engaged.DW.STP.HighHaste = set_combine(sets.engaged.DW.HighHaste, {
      head=gear.Herc_STP_head,
      ring1={name="シーリチリング+1", bag="wardrobe7"},
      ring2={name="シーリチリング+1", bag="wardrobe8"},
      })

  -- 45% Magic Haste (36% DW to cap)
  sets.engaged.DW.MaxHaste = {
      head={ name="アデマボンネット+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
      body={ name="アデマジャケット+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
      --head=gear.Adhemar_B_head,
      --body=gear.Adhemar_B_body, --6
      --hands=gear.Adhemar_B_hands,
      hands={ name="アデマリスト+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
      legs="サムヌータイツ",
      --feet=gear.Herc_TA_feet,
      feet="マリグナスブーツ",
      neck="イスクルゴルゲット",
      ear1="素破の耳", --5
      ear2="テロスピアス",
      ring1="ヘタイロイリング",
      ring2="エポナリング",
      back=gear.RNG_TP_Cape,
      waist="ウィンバフベルト+1",
      } -- 11%

  sets.engaged.DW.LowAcc.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {
      --head="Dampening Tam",
      head="マリグナスシャポー",
      --hands=gear.Adhemar_A_hands,
      hands={ name="アデマリスト+1", augments={'DEX+12','AGI+12','Accuracy+20',}},
      ring1={name="シーリチリング+1", bag="wardrobe7"},
      waist="ケンタークベルト+1",
      })

  sets.engaged.DW.MidAcc.MaxHaste = set_combine(sets.engaged.DW.LowAcc.MaxHaste, {
      legs="メガナダショウス+2",
      neck="コンバタントトルク",
      ring2="イラブラットリング",
      })

  sets.engaged.DW.HighAcc.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, {
      head="カマインマスク+1",
      hands="ガズブレスレット+1",
      legs="カマインクウィス+1",
      ear1="セサンスピアス",
      ear2="マーケピアス+1",
      ring1="Regal Ring",
      ring2={name="シーリチリング+1", bag="wardrobe8"},
      waist="オルセニベルト",
      })

  sets.engaged.DW.STP.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {
      head=gear.Herc_STP_head,
      ring1={name="シーリチリング+1", bag="wardrobe7"},
      ring2={name="シーリチリング+1", bag="wardrobe8"},
      })

  sets.engaged.DW.MaxHastePlus = set_combine(sets.engaged.DW.MaxHaste, {back=gear.RNG_DW_Cape})
  sets.engaged.DW.LowAcc.MaxHastePlus = set_combine(sets.engaged.DW.LowAcc.MaxHaste, {back=gear.RNG_DW_Cape})
  sets.engaged.DW.MidAcc.MaxHastePlus = set_combine(sets.engaged.DW.MidAcc.MaxHaste, {back=gear.RNG_DW_Cape})
  sets.engaged.DW.HighAcc.MaxHastePlus = set_combine(sets.engaged.DW.HighAcc.MaxHaste, {back=gear.RNG_DW_Cape})
  sets.engaged.DW.STP.MaxHastePlus = set_combine(sets.engaged.DW.STP.MaxHaste, {back=gear.RNG_DW_Cape})


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Hybrid Sets -------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.engaged.Hybrid = {
      head=gear.Adhemar_D_head, --4/0
      neck="ロリケートトルク+1", --6/6
      ring2="守りの指輪", --10/10
      }

  sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
  sets.engaged.LowAcc.DT = set_combine(sets.engaged.LowAcc, sets.engaged.Hybrid)
  sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.engaged.Hybrid)
  sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.engaged.Hybrid)
  sets.engaged.STP.DT = set_combine(sets.engaged.STP, sets.engaged.Hybrid)

  sets.engaged.DW.DT = set_combine(sets.engaged.DW, sets.engaged.Hybrid)
  sets.engaged.DW.LowAcc.DT = set_combine(sets.engaged.DW.LowAcc, sets.engaged.Hybrid)
  sets.engaged.DW.MidAcc.DT = set_combine(sets.engaged.DW.MidAcc, sets.engaged.Hybrid)
  sets.engaged.DW.HighAcc.DT = set_combine(sets.engaged.DW.HighAcc, sets.engaged.Hybrid)
  sets.engaged.DW.STP.DT = set_combine(sets.engaged.DW.STP, sets.engaged.Hybrid)

  sets.engaged.DW.DT.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.Hybrid)
  sets.engaged.DW.LowAcc.DT.LowHaste = set_combine(sets.engaged.DW.LowAcc.LowHaste, sets.engaged.Hybrid)
  sets.engaged.DW.MidAcc.DT.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, sets.engaged.Hybrid)
  sets.engaged.DW.HighAcc.DT.LowHaste = set_combine(sets.engaged.DW.HighAcc.LowHaste, sets.engaged.Hybrid)
  sets.engaged.DW.STP.DT.LowHaste = set_combine(sets.engaged.DW.STP.LowHaste, sets.engaged.Hybrid)

  sets.engaged.DW.DT.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.Hybrid)
  sets.engaged.DW.LowAcc.DT.MidHaste = set_combine(sets.engaged.DW.LowAcc.MidHaste, sets.engaged.Hybrid)
  sets.engaged.DW.MidAcc.DT.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, sets.engaged.Hybrid)
  sets.engaged.DW.HighAcc.DT.MidHaste = set_combine(sets.engaged.DW.HighAcc.MidHaste, sets.engaged.Hybrid)
  sets.engaged.DW.STP.DT.MidHaste = set_combine(sets.engaged.DW.STP.MidHaste, sets.engaged.Hybrid)

  sets.engaged.DW.DT.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.Hybrid)
  sets.engaged.DW.LowAcc.DT.HighHaste = set_combine(sets.engaged.DW.LowAcc.HighHaste, sets.engaged.Hybrid)
  sets.engaged.DW.MidAcc.DT.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, sets.engaged.Hybrid)
  sets.engaged.DW.HighAcc.DT.HighHaste = set_combine(sets.engaged.DW.HighAcc.HighHaste, sets.engaged.Hybrid)
  sets.engaged.DW.STP.DT.HighHaste = set_combine(sets.engaged.DW.HighHaste.STP, sets.engaged.Hybrid)

  sets.engaged.DW.DT.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.Hybrid)
  sets.engaged.DW.LowAcc.DT.MaxHaste = set_combine(sets.engaged.DW.LowAcc.MaxHaste, sets.engaged.Hybrid)
  sets.engaged.DW.MidAcc.DT.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, sets.engaged.Hybrid)
  sets.engaged.DW.HighAcc.DT.MaxHaste = set_combine(sets.engaged.DW.HighAcc.MaxHaste, sets.engaged.Hybrid)
  sets.engaged.DW.STP.DT.MaxHaste = set_combine(sets.engaged.DW.STP.MaxHaste, sets.engaged.Hybrid)

  sets.engaged.DW.DT.MaxHastePlus = set_combine(sets.engaged.DW.MaxHastePlus, sets.engaged.Hybrid)
  sets.engaged.DW.LowAcc.DT.MaxHastePlus = set_combine(sets.engaged.DW.LowAcc.MaxHastePlus, sets.engaged.Hybrid)
  sets.engaged.DW.MidAcc.DT.MaxHastePlus = set_combine(sets.engaged.DW.MidAcc.MaxHastePlus, sets.engaged.Hybrid)
  sets.engaged.DW.HighAcc.DT.MaxHastePlus = set_combine(sets.engaged.DW.HighAcc.MaxHastePlus, sets.engaged.Hybrid)
  sets.engaged.DW.STP.DT.MaxHastePlus = set_combine(sets.engaged.DW.STP.MaxHastePlus, sets.engaged.Hybrid)


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Special Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.buff.Barrage = {hands="ＯＲブレーサー+1"}
  sets.buff['ベロシティショット'] = set_combine(sets.midcast.RA, {body="ＡＭカバン+1", back=gear.RNG_TP_Cape})
  sets.buff.Camouflage = {body="ＯＲジャーキン+3"}

  sets.buff.Doom = {
      neck="Nicander's Necklace", --20
      ring1={name="Eshmun's Ring", bag="wardrobe3"}, --20
      ring2={name="Eshmun's Ring", bag="wardrobe4"}, --20
      waist="ギシドゥヴァサシェ", --10
      }

  sets.FullTP = {ear1="Crematio Earring"}
  sets.Obi = {waist="八輪の帯"}
  --sets.Reive = {neck="Ygnas's Resolve +1"}
  -- sets.CP = {back="Mecisto. Mantle"}

  sets.Annihilator = {main="ペルーン+1", sub="ブラーナイフ+1", ranged="アナイアレイター"}
  sets.Fomalhaut = {main="ペルーン+1", sub="ブラーナイフ+1", ranged="フォーマルハウト"}
  sets.Armageddon = {main="ペルーン+1", sub="マレヴォンス", ranged="アルマゲドン"}
  --sets.Gastraphetes = {main="Malevolence", sub="Malevolence", ranged="Gastraphetes"}

  sets.DefaultShield = {sub="ヌスクシールド"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
  if spell.action_type == 'Ranged Attack' then
      state.CombatWeapon:set(player.equipment.range)
  end
  -- Check that proper ammo is available if we're using ranged attacks or similar.
  if spell.action_type == 'Ranged Attack' or (spell.type == 'WeaponSkill' and (spell.skill == 'Marksmanship' or spell.skill == 'Archery')) then
      check_ammo(spell, action, spellMap, eventArgs)
  end
  if spellMap == '空蝉' then
      if buffactive['分身(3)'] or buffactive['分身(4+)'] then
          cancel_spell()
          add_to_chat(123, '**!! '..spell.english..' Canceled: [3+ IMAGES] !!**')
          eventArgs.handled = true
          return
      elseif buffactive['分身'] or buffactive['分身(2)'] then
          send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')
      end
  end
end

function job_post_precast(spell, action, spellMap, eventArgs)
  if spell.action_type == 'Ranged Attack' then
      if spell.action_type == 'Ranged Attack' then
          if player.equipment.ranged == "ガストラフェテス" then
              if flurry == 2 then
                  equip(sets.precast.RA.Gastra.Flurry2)
              elseif flurry == 1 then
                  equip(sets.precast.RA.Gastra.Flurry1)
              else
                  equip(sets.precast.RA.Gastra)
              end
          else
              if flurry == 2 then
                  equip(sets.precast.RA.Flurry2)
              elseif flurry == 1 then
                  equip(sets.precast.RA.Flurry1)
              else
                  equip(sets.precast.RA)
              end
          end
          if player.equipment.main == "ペルーン+1" then
              equip({waist="イェマヤベルト"})
          end
      end
    elseif spell.type == 'WeaponSkill' then
      -- Replace TP-bonus gear if not needed.
      if spell == 'トゥルーフライト' or spell == 'イオリアンエッジ' and player.tp > 2900 then
          equip(sets.FullTP)
      end
      -- Equip obi if weather/day matches for WS.
      if elemental_ws:contains(spell.name) then
          -- Matching double weather (w/o day conflict).
          if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
              equip({waist="八輪の帯"})
          -- Target distance under 1.7 yalms.
          elseif spell.target.distance < (1.7 + spell.target.model_size) then
              equip({waist="オルペウスサッシュ"})
          -- Matching day and weather.
          elseif spell.element == world.day_element and spell.element == world.weather_element then
              equip({waist="八輪の帯"})
          -- Target distance under 8 yalms.
          elseif spell.target.distance < (8 + spell.target.model_size) then
              equip({waist="オルペウスサッシュ"})
          -- Match day or weather.
          elseif spell.element == world.day_element or spell.element == world.weather_element then
              equip({waist="八輪の帯"})
          end
      end
  end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_post_midcast(spell, action, spellMap, eventArgs)
  if spell.action_type == 'Ranged Attack' then
      if buffactive['ダブルショット'] then
          equip(sets.DoubleShot)
          if buffactive['アフターマス: Lv.3'] and player.equipment.ranged == "アルマゲドン" then
              equip(sets.DoubleShotCritical)
              if (spell.target.distance < (7 + spell.target.model_size)) and (spell.target.distance > (5 + spell.target.model_size)) then
                  equip(sets.TrueShot)
              end
          end
      elseif buffactive['アフターマス: Lv.3'] and player.equipment.ranged == "アルマゲドン" then
          equip(sets.midcast.RA.Critical)
          if (spell.target.distance < (7 + spell.target.model_size)) and (spell.target.distance > (5 + spell.target.model_size)) then
              equip(sets.TrueShot)
          end
      end
      if state.Buff.Barrage then
          equip(sets.buff.Barrage)
      end
--        if state.Buff['Velocity Shot'] and state.RangedMode.value == 'STP' then
--            equip(sets.buff['Velocity Shot'])
--        end
  end
end


function job_aftercast(spell, action, spellMap, eventArgs)
  if spell == "影縫い" then
      send_command('@timers c "Shadowbind ['..spell.target.name..']" 42 down abilities/00122.png')
  end
  if player.status ~= 'Engaged' and state.WeaponLock.value == false then
      check_weaponset()
  end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff,gain)
-- If we gain or lose any flurry buffs, adjust gear.
  if S{'flurry'}:contains(buff:lower()) then
      if not gain then
          flurry = nil
          add_to_chat(122, "Flurry status cleared.")
      end
      if not midaction() then
          handle_equipping_gear(player.status)
      end
  end

  if buff == "カモフラージュ" then
      if gain then
          equip(sets.buff.Camouflage)
          disable('body')
      else
          enable('body')
      end
  end

--    if buffactive['Reive Mark'] then
--        if gain then
--            equip(sets.Reive)
--            disable('neck')
--        else
--            enable('neck')
--        end
--    end

  if buff == "doom" then
      if gain then
          equip(sets.buff.Doom)
          send_command('@input /p Doomed.')
          disable('ring1','ring2','waist')
      else
          enable('ring1','ring2','waist')
          handle_equipping_gear(player.status)
      end
  end

end

function job_state_change(stateField, newValue, oldValue)
  --if state.WeaponLock.value == true then
  --    disable('ranged')
  --else
  --    enable('ranged')
 -- end

  check_weaponset()
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
  check_gear()
  update_combat_form()
  determine_haste_group()
  check_moving()
end

function job_update(cmdParams, eventArgs)
  handle_equipping_gear(player.status)
end

function update_combat_form()
  if DW == true then
      state.CombatForm:set('DW')
  elseif DW == false then
      state.CombatForm:reset()
  end
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
  if buffactive['アフターマス: Lv.3'] and player.equipment.main == "カルンウェナン" then
      meleeSet = set_combine(meleeSet, sets.engaged.Aftermath)
  end

  check_weaponset()

  return meleeSet
end

function get_custom_wsmode(spell, action, spellMap)
  local wsmode
  if (spell.skill == 'Marksmanship' or spell.skill == 'Archery') then
      if state.RangedMode.value == 'Acc' or state.RangedMode.value == 'HighAcc' then
          wsmode = 'Acc'
          add_to_chat(1, 'WS Mode Auto Acc')
      end
  elseif (spell.skill ~= 'Marksmanship' and spell.skill ~= 'Archery') then
      if state.OffenseMode.value == 'Acc' or state.OffenseMode.value == 'HighAcc' then
          wsmode = 'Acc'
      end
  end

  return wsmode
end

function customize_idle_set(idleSet)
  -- if state.CP.current == 'on' then
  --     equip(sets.CP)
  --     disable('back')
  -- else
  --     enable('back')
  -- end
  if state.Auto_Kite.value == true then
     idleSet = set_combine(idleSet, sets.Kiting)
  end

  return idleSet
end

function display_current_job_state(eventArgs)
  local cf_msg = ''
  if state.CombatForm.has_value then
      cf_msg = ' (' ..state.CombatForm.value.. ')'
  end

  local m_msg = state.OffenseMode.value
  if state.HybridMode.value ~= 'Normal' then
      m_msg = m_msg .. '/' ..state.HybridMode.value
  end

  local ws_msg = state.WeaponskillMode.value

  local d_msg = 'None'
  if state.DefenseMode.value ~= 'None' then
      d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
  end

  local i_msg = state.IdleMode.value

  local msg = ''
  if state.Kiting.value then
      msg = msg .. ' Kiting: On |'
  end

  add_to_chat(002, '| ' ..string.char(31,210).. 'Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
      ..string.char(31,207).. ' WS: ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
      ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
      ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
      ..string.char(31,002)..msg)

  eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

--Read incoming packet to differentiate between Haste/Flurry I and II
windower.register_event('action',
  function(act)
      --check if you are a target of spell
      local actionTargets = act.targets
      playerId = windower.ffxi.get_player().id
      isTarget = false
      for _, target in ipairs(actionTargets) do
          if playerId == target.id then
              isTarget = true
          end
      end
      if isTarget == true then
          if act.category == 4 then
              local param = act.param
              if param == 845 and flurry ~= 2 then
                  --add_to_chat(122, 'Flurry Status: Flurry I')
                  flurry = 1
              elseif param == 846 then
                  --add_to_chat(122, 'Flurry Status: Flurry II')
                  flurry = 2
            end
          end
      end
  end)

function determine_haste_group()
  classes.CustomMeleeGroups:clear()
  if DW == true then
      if DW_needed <= 11 then
          classes.CustomMeleeGroups:append('MaxHaste')
      elseif DW_needed > 11 and DW_needed <= 21 then
          classes.CustomMeleeGroups:append('MaxHastePlus')
      elseif DW_needed > 21 and DW_needed <= 27 then
          classes.CustomMeleeGroups:append('HighHaste')
      elseif DW_needed > 27 and DW_needed <= 31 then
          classes.CustomMeleeGroups:append('MidHaste')
      elseif DW_needed > 31 and DW_needed <= 42 then
          classes.CustomMeleeGroups:append('LowHaste')
      elseif DW_needed > 42 then
          classes.CustomMeleeGroups:append('')
      end
  end
end

function job_self_command(cmdParams, eventArgs)
  gearinfo(cmdParams, eventArgs)
end

function gearinfo(cmdParams, eventArgs)
  if cmdParams[1] == 'gearinfo' then
      if type(tonumber(cmdParams[2])) == 'number' then
          if tonumber(cmdParams[2]) ~= DW_needed then
          DW_needed = tonumber(cmdParams[2])
          DW = true
          end
      elseif type(cmdParams[2]) == 'string' then
          if cmdParams[2] == 'false' then
              DW_needed = 0
              DW = false
          end
      end
      if type(tonumber(cmdParams[3])) == 'number' then
          if tonumber(cmdParams[3]) ~= Haste then
              Haste = tonumber(cmdParams[3])
          end
      end
      if type(cmdParams[4]) == 'string' then
          if cmdParams[4] == 'true' then
              moving = true
          elseif cmdParams[4] == 'false' then
              moving = false
          end
      end
      if not midaction() then
          job_update()
      end
  end
end

-- Check for proper ammo when shooting or weaponskilling
function check_ammo(spell, action, spellMap, eventArgs)
  if spell.action_type == 'Ranged Attack' then
      if player.equipment.ammo == 'empty' or player.equipment.ammo ~= DefaultAmmo[player.equipment.range] then
          if DefaultAmmo[player.equipment.range] then
              if player.inventory[DefaultAmmo[player.equipment.range]] then
                  --add_to_chat(3,"Using Default Ammo")
                  equip({ammo=DefaultAmmo[player.equipment.range]})
              else
                  add_to_chat(3,"Default ammo unavailable.  Leaving empty.")
              end
          else
              add_to_chat(3,"Unable to determine default ammo for current weapon.  Leaving empty.")
          end
      end
  elseif spell.type == 'WeaponSkill' then
      -- magical weaponskills
      if elemental_ws:contains(spell.english) then
          if player.inventory[MagicAmmo[player.equipment.range]] then
              equip({ammo=MagicAmmo[player.equipment.range]})
          else
              add_to_chat(3,"Magic ammo unavailable.  Using default ammo.")
              equip({ammo=DefaultAmmo[player.equipment.range]})
          end
      --physical weaponskills
      else
          if state.RangedMode.value == 'Acc' then
              if player.inventory[AccAmmo[player.equipment.range]] then
                  equip({ammo=AccAmmo[player.equipment.range]})
              else
                  add_to_chat(3,"Acc ammo unavailable.  Using default ammo.")
                  equip({ammo=DefaultAmmo[player.equipment.range]})
              end
          else
              if player.inventory[WSAmmo[player.equipment.range]] then
                  equip({ammo=WSAmmo[player.equipment.range]})
              else
                  add_to_chat(3,"WS ammo unavailable.  Using default ammo.")
                  equip({ammo=DefaultAmmo[player.equipment.range]})
              end
          end
      end
  end
  if player.equipment.ammo ~= 'empty' and player.inventory[player.equipment.ammo].count < 15 then
      add_to_chat(39,"*** Ammo '"..player.inventory[player.equipment.ammo].shortname.."' running low! *** ("..player.inventory[player.equipment.ammo].count..")")
  end
end

function update_offense_mode()
  if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
      state.CombatForm:set('DW')
  else
      state.CombatForm:reset()
  end
end

function check_moving()
  if state.DefenseMode.value == 'None'  and state.Kiting.value == false then
      if state.Auto_Kite.value == false and moving then
          state.Auto_Kite:set(true)
      elseif state.Auto_Kite.value == true and moving == false then
          state.Auto_Kite:set(false)
      end
  end
end

function check_gear()
  if no_swap_gear:contains(player.equipment.left_ring) then
      disable("ring1")
  else
      enable("ring1")
  end
  if no_swap_gear:contains(player.equipment.right_ring) then
      disable("ring2")
  else
      enable("ring2")
  end
  if no_swap_gear:contains(player.equipment.waist) then
      disable("waist")
  else
      enable("waist")
  end
end

function check_weaponset()
  if state.OffenseMode.value == 'LowAcc' or state.OffenseMode.value == 'MidAcc' or state.OffenseMode.value == 'HighAcc' then
      equip(sets[state.WeaponSet.current].Acc)
  else
      equip(sets[state.WeaponSet.current])
  end
  if player.sub_job ~= 'NIN' and player.sub_job ~= 'DNC' then
     equip(sets.DefaultShield)
  end
end

windower.register_event('zone change',
  function()
      if no_swap_gear:contains(player.equipment.left_ring) then
          enable("ring1")
          equip(sets.idle)
      end
      if no_swap_gear:contains(player.equipment.right_ring) then
          enable("ring2")
          equip(sets.idle)
      end
      if no_swap_gear:contains(player.equipment.waist) then
          enable("waist")
          equip(sets.idle)
      end
  end
)

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
  set_macro_page(1, 6)
end

function set_lockstyle()
  send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end