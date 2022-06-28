-- Original: Motenten / Modified: Arislan

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Mode
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ CTRL+F11 ]        Cycle Casting Modes
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+R ]           Toggle Regen Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--  Abilities:  [ CTRL+` ]          Afflatus Solace
--              [ ALT+` ]           Afflatus Misery
--              [ CTRL+[ ]          Divine Seal
--              [ CTRL+] ]          Divine Caress
--              [ CTRL+` ]          Composure
--              [ CTRL+- ]          Light Arts/Addendum: White
--              [ CTRL+= ]          Dark Arts/Addendum: Black
--              [ CTRL+; ]          Celerity/Alacrity
--              [ ALT+[ ]           Accesion/Manifestation
--              [ ALT+; ]           Penury/Parsimony
--
--  Spells:     [ ALT+O ]           Regen IV
--
--  Weapons:    [ CTRL+W ]          Toggles Weapon Lock
--
--  WS:         [ CTRL+Numpad7 ]    Black Halo
--              [ CTRL+Numpad8 ]    Hexa Strike
--              [ CTRL+Numpad9 ]    Realmrazer
--              [ CTRL+Numpad1 ]    Flash Nova
--              [ CTRL+Numpad0 ]    Mystic Boon
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--              Addendum Commands:
--              Shorthand versions for each strategem type that uses the version appropriate for
--              the current Arts.
--                                          Light Arts                    Dark Arts
--                                          ----------                  ---------
--              gs c scholar light          Light Arts/Addendum
--              gs c scholar dark                                       Dark Arts/Addendum
--              gs c scholar cost           Penury                      Parsimony
--              gs c scholar speed          Celerity                    Alacrity
--              gs c scholar aoe            Accession                   Manifestation
--              gs c scholar addendum       Addendum: White             Addendum: Black


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
  function get_sets()
    set_language('japanese')

    mote_include_version = 2
    -- Load and initialize the include file.
    include('Mote-Include.lua')
    res = require 'resources'
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['ハートオブソラス'] = buffactive['ハートオブソラス'] or false
    state.Buff['ハートオブミゼリ'] = buffactive['ハートオブミゼリ'] or false
    state.Buff['机上演習:蓄積中'] = buffactive['机上演習:蓄積中'] or false
    state.Buff['机上演習:蓄積完了'] = buffactive['机上演習:蓄積完了'] or false

    state.RegenMode = M{['description']='Regen Mode', 'Duration', 'Potency'}

    no_swap_gear = S{"デジョンリング", "Ｄ．デムリング", "Ｄ．ホラリング", "Ｄ．メアリング",
              "トリゼックリング", "エチャドリング", "ファシリティリング", "キャパシティリング"}

    lockstyleset = 1
    include('Mote-TreasureHunter')
    include('Mote-Display')
    include('weather_obi')
    include('mystyle')
    include('myexport')

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'DT', 'MEva')

    state.BarElement = M{['description']='BarElement', 'バファイラ', 'バブリザラ', 'バエアロラ', 'バストランラ', 'バサンダラ', 'バウォタラ'}
    state.BarStatus = M{['description']='BarStatus', 'バアムネジラ', 'バウィルラ', 'バパライラ', 'バサイレラ', 'バブレクラ','バポイゾラ', 'バブライラ', 'バスリプラ' }
    state.BoostSpell = M{['description']='BoostSpell', 'アディスト', 'アディイン', 'アディアジル', 'アディバイト', 'アディデック', 'アディマイン', 'アディカリス'}

    state.WeaponLock = M(false, 'Weapon Lock')
    -- state.CP = M(false, "Capacity Points Mode")

    -- Additional local binds
    --include('Global-Binds.lua') -- OK to remove this line
    --include('Global-GEO-Binds.lua') -- OK to remove this line

    send_command('bind ^` input /ja '..windower.to_shift_jis("ハートオブ¥¥¥ソラス")..' <me>')
    send_command('bind !` input /ja '..windower.to_shift_jis("ハートオブミゼリ")..' <me>')
    send_command('bind ^- gs c scholar light')
    send_command('bind ^= gs c scholar dark')
    send_command('bind !- gs c scholar addendum')
    send_command('bind != gs c scholar addendum')
    send_command('bind ^; gs c scholar speed')
    send_command('bind ![ gs c scholar aoe')
    send_command('bind !; gs c scholar cost')
    send_command('bind ^insert gs c cycleback BoostSpell')
    send_command('bind ^delete gs c cycle BoostSpell')
    send_command('bind ^home gs c cycleback BarElement')
    send_command('bind ^end gs c cycle BarElement')
    send_command('bind ^pageup gs c cycleback BarStatus')
    send_command('bind ^pagedown gs c cycle BarStatus')
    send_command('bind ^[ input /ja '..windower.to_shift_jis("女神の印")..' <me>')
    send_command('bind ^] input /ja '..windower.to_shift_jis("女神の愛撫")..' <me>')
    send_command('bind !o input /ma '..windower.to_shift_jis("リジェネIV")..' <stpc>')
    -- send_command('bind @c gs c toggle CP')
    send_command('bind @r gs c cycle RegenMode')
    send_command('bind @w gs c toggle WeaponLock')

    send_command('bind ^numpad7 input /ws '..windower.to_shift_jis("ブラックヘイロー")..' <t>')
    send_command('bind ^numpad8 input /ws '..windower.to_shift_jis("ヘキサストライク")..' <t>')
    send_command('bind ^numpad5 input /ws '..windower.to_shift_jis("レルムレイザー")..' <t>')
    send_command('bind ^numpad1 input /ws '..windower.to_shift_jis("フラッシュノヴァ")..' <t>')
    send_command('bind ^numpad0 input /ws '..windower.to_shift_jis("ミスティックブーン")..' <t>')


    bool_state = {}
    mode_state = {
      {label="Offence", mode="OffenseMode"},
      {label='Casting', mode='CastingMode'},
      {label='Idle', mode='IdleMode'},
  }
    init_job_states(bool_state, mode_state)
    select_default_macro_book()
    set_lockstyle()

    state.Auto_Kite = M(false, 'Auto_Kite')
    DW = false
    moving = false
    update_combat_form()
end

function binds_on_load()
  send_command('bind f1 gs c cycle OffenseMode')
  send_command('bind f3 gs c cycle IdleMode')
  send_command('bind ^f3 gs c cycle CastingMode')
  send_command('bind f4 gs c update user')
  send_command('bind ^f4 gs c cycle TreasureMode')

  -- send_command('bind !f4 gs c reset DefenseMode')
  -- send_command('bind f2 gs c set DefenseMode Physical')
  -- send_command('bind ^f2 gs c cycle PhysicalDefenseMode')
  -- send_command('bind !f2 gs c toggle Kiting')
  -- send_command('bind f3 gs c set DefenseMode Magical')

  -- send_command('bind ^- gs c toggle selectnpctargets')
  -- send_command('bind ^= gs c cycle pctargetmode')
end
function user_unload()
  send_command('unbind f1')
  send_command('unbind ^f1')
  send_command('unbind f2')
  send_command('unbind ^f2')
  send_command('unbind f3')
  -- send_command('unbind ^f3')
  send_command('unbind f4')
  send_command('unbind ^f4')
    --[[send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind ^-')
    send_command('unbind ^=')
    send_command('unbind !-')
    send_command('unbind !=')
    send_command('unbind ^;')
    send_command('unbind ![')
    send_command('unbind !;')
    send_command('unbind ^insert')
    send_command('unbind ^delete')
    send_command('unbind ^home')
    send_command('unbind ^end')
    send_command('unbind ^pageup')
    send_command('unbind ^pagedown')
    send_command('unbind ^[')
    send_command('unbind ^]')
    send_command('unbind !o')
    -- send_command('unbind @c')
    send_command('unbind @r')
    send_command('unbind @w')
    send_command('unbind ^numpad7')
    send_command('unbind ^numpad8')
    send_command('unbind ^numpad5')
    send_command('unbind ^numpad1')
    send_command('unbind ^numpad0')

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

    send_command('unbind 1')
    send_command('unbind 2')
    send_command('unbind 3')
    send_command('unbind 4')
    send_command('unbind 5')
    send_command('unbind 6')]]

end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets

    -- Fast cast sets for spells
    sets.TreasureHunter = {
      --head="ヴォルトキャップ",
      --legs={ name="マーリンシャルワ", augments={'CHR+9','MND+2','"Treasure Hunter"+2',}},
      --waist="チャークベルト",
      head="白ララブキャップ+1",
      -- legs={ name="ヘルクリアトラウザ", augments={'MND+10','"Rapid Shot"+3','"Treasure Hunter"+2',}},
      --feet={ name="マーリンクラッコー", augments={'"Mag.Atk.Bns."+17','Pet: "Dbl. Atk."+2','"Treasure Hunter"+2','Accuracy+8 Attack+8',}},
      waist="チャークベルト",
  }

    sets.precast.FC = {
    --  /SCH --3
        --main="C. Palug Hammer", --7
        main={ name="アスクレピウス", augments={'Path: C',}},
        --sub="Chanter's Shield", --3
        sub={ name="玄武盾", augments={'"Cure" potency +5%','"Cure" spellcasting time -6%','MP+27',}},
        --ammo="Impatiens", --(2)
        ammo="ホミリアリ",
        --head="Volte Beret", --6
        head={ name="カイロンハット", augments={'Rng.Atk.+24','Mag. Acc.+22 "Mag.Atk.Bns."+22','"Refresh"+2','Accuracy+8 Attack+8',}},
        --body="Inyanga Jubbah +2", --14
        --body={ name="ケカスブリオー+1", augments={'MP+80','"Cure" potency +6%','"Conserve MP"+7',}},
        body="ピンガチュニック+1",
        --hands="Gende. Gages +1", --7
        --hands={ name="カイロングローブ", augments={'DEX+4','Phys. dmg. taken -2%','"Refresh"+2','Mag. Acc.+10 "Mag.Atk.Bns."+10',}},
        hands={ name="ファナチクグローブ", augments={'MP+50','Healing magic skill +10','"Conserve MP"+7','"Fast Cast"+7',}},
        --legs="Volte Brais", --8
        --legs={ name="カイロンホーズ", augments={'Accuracy+6','Pet: Mag. Acc.+22','"Refresh"+2','Mag. Acc.+4 "Mag.Atk.Bns."+4',}},
        legs="ピンガズボン+1",
        --feet="Volte Gaiters", --6
        feet={ name="カイロンスリッパー", augments={'Pet: Mag. Acc.+29','Accuracy+25','"Refresh"+2','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
        --neck="Clr. Torque +2", --10
        neck={ name="クレリクトルク+2", augments={'Path: A',}},
        --ear1="Malignance Earring", --4
        --ear2="Enchntr. Earring +1", --2
        ear1="ロケイシャスピアス",
        ear2="マリグナスピアス",
        ring1="ＷＬリング+1", --6(4)
        ring2="守りの指輪", --(2)
        --back="Perimede Cape", --(4)
        back={ name="アラウナスケープ", augments={'MP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10',}},
        --waist="Embla Sash", --5
        waist="風鳥の帯",
        }

    sets.precast.FC['強化魔法'] = set_combine(sets.precast.FC, {
        waist="ジーゲルサッシュ",
        })

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
        --ammo="Impatiens", --(2)
        --head="Piety Cap +3", --15
        head={ name="ケカスミトラ+1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
        --feet="Kaykaus Boots +1", --7
        feet={ name="ケカスブーツ+1", augments={'Mag. Acc.+20','"Cure" potency +6%','"Fast Cast"+4',}},
        ear1="朝露の耳飾", --6(4)
        ear2="メンデカントピアス", --(2)
        --back="Perimede Cape", --(4)
        back={ name="アラウナスケープ", augments={'MP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10',}},
        --waist="Shinjutsu-no-Obi +1", --5
        waist="光輪の帯",
        })

    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.CureSolace = sets.precast.FC.Cure
    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty, body="トワイライトプリス", waist="神術帯+1"})
    sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="デイブレイクワンド", sub="アムラピシールド"})

    -- Precast sets to enhance JAs
    --sets.precast.JA.Benediction = {}

    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        --ammo="Floestone",
        --head="Piety Cap +3",
        head={ name="ＰＩキャップ+3", augments={'Enhances "Devotion" effect',}},
        --body="Piety Briault +3",
        body={ name="ＰＩブリオー+3", augments={'Enhances "Benediction" effect',}},
        --hands="Piety Mitts +3",
        hands={ name="ＰＩミトン+3", augments={'Enhances "Martyr" effect',}},
        --legs="Piety Pantaln. +3",
        legs={ name="ＰＩパンタロン+3", augments={'Enhances "Afflatus Misery" effect',}},
        feet={ name="ＰＩダックビル+3", augments={'Enhances "Afflatus Solace" effect',}},
        --feet="Piety Duckbills +2",
        neck="フォシャゴルゲット",
        ear1={ name="胡蝶のイヤリング", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        ear2="イシュヴァラピアス",
        ring1="エパミノダスリング",
        ring2="Shukuyu Ring",
        back=gear.WHM_WS_Cape,
        waist="フォシャベルト",
        }

    sets.precast.WS['ブラックヘイロー'] = set_combine(sets.precast.WS, {
        neck="Caro Necklace",
        })

    sets.precast.WS['ヘキサストライク'] = set_combine(sets.precast.WS, {
        head="Blistering Sallet +1",
        ring2="Begrudging Ring",
        back=gear.WHM_DA_Cape,
        })

    sets.precast.WS['フラッシュノヴァ'] = set_combine(sets.precast.WS, {
        ammo="Ghastly Tathlum +1",
        head=empty;
        body="Cohort Cloak +1",
        --legs="Kaykaus Tights +1",
        legs={ name="ケカスタイツ+1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
        })

    -- Midcast Sets

    sets.midcast.FC = sets.precast.FC

    sets.midcast.ConserveMP = {
        --main="Sucellus",
        --sub="Thuellaic Ecu +1",
        --head="Vanya Hood",
        --head={ name="ヴァニヤフード", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
        head={ name="ヴァニヤフード", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
        --body="Vedic Coat",
        --hands="Shrieker's Cuffs",
        --legs="Vanya Slops",
        feet={ name="ケカスブーツ+1", augments={'Mag. Acc.+20','"Cure" potency +6%','"Fast Cast"+4',}},
        --feet="Kaykaus Boots +1",
        --ear2="メンデカントピアス",
        back="ソレムニティケープ",
        waist="神術帯+1",
        }

    -- Cure sets

    sets.midcast.CureSolace = {
        main="レテクロッド+1", --23(+10)
        --sub="Sors Shield", --3/(-5)
        sub={ name="玄武盾", augments={'"Cure" potency +5%','"Cure" spellcasting time -6%','MP+27',}},
        ammo="ペムフレドタスラム",
        --head="Kaykaus Mitra +1", --11(+2)/(-6)
        head={ name="ケカスミトラ+1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
        --body="Ebers Bliaud +1"
        body="ＥＢブリオー+1",
        --hands="Theophany Mitts +3", --(+4)/(-7)
        hands="ＴＥミトン+3",
        --legs="Ebers Pant. +1",
        legs="ＥＢパンタロン+1",
        --feet="Kaykaus Boots +1", --11(+2)/(-12)
        feet={ name="ケカスブーツ+1", augments={'Mag. Acc.+20','"Cure" potency +6%','"Fast Cast"+4',}},
        --neck="Clr. Torque +2", --10/(-25)
        neck={ name="クレリクトルク+2", augments={'Path: A',}},
        --ear1="Glorious Earring", -- (+2)/(-5)
        --ear2="Magnetic Earring",
        ear1="メンデカントピアス", --(2)
        ear2="朝露の耳飾", --6(4)
        ring1="ハオマリング",
        ring2="守りの指輪", --3/(-5)
        back=gear.WHM_Cure_Cape, --10
        waist="神術帯+1",
      }

    sets.midcast.CureSolaceWeather = set_combine(sets.midcast.CureSolace, {
        --ear2="Nourish. Earring +1", --7
        back="黄昏の羽衣",
        waist="光輪の帯",
        })

    sets.midcast.CureNormal = set_combine(sets.midcast.CureSolace, {
        --body="Theo. Briault +3", --0(+6)/(-6)
        body="ＴＥブリオー+3",
        })

    sets.midcast.CureWeather = set_combine(sets.midcast.CureNormal, {
        --hands="Kaykaus Cuffs +1", --11/(-6)
        hands={ name="ケカスカフス+1", augments={'MP+80','MND+12','Mag. Acc.+20',}},
        --ear2="Nourish. Earring +1", --7
        --back="Twilight Cape",
        --waist="Hachirin-no-Obi",
        back="黄昏の羽衣",
        waist="光輪の帯",
        })

    sets.midcast.CuragaNormal = set_combine(sets.midcast.CureNormal, {
        --body="Theo. Briault +3", --0(+6)/(-6)
        body="ＴＥブリオー+3",
        ring1={name="スティキニリング+1", bag="Wardrobe 2"},
        --right_ring={name="スティキニリング+1", bag="Wardrobe 3"},
        ring2={ name="メタモルリング+1", augments={'Path: A',}},
        --ring1={name="Stikini Ring +1", bag="wardrobe3"},
        --ring2="Metamor. Ring +1",
        --waist="Luminary Sash",
        waist="ルーミネリサッシュ",
        })

    sets.midcast.CuragaWeather = {
        --body="Theo. Briault +3", --0(+6)/(-6)
        body="ＴＥブリオー+3",
        --hands="Kaykaus Cuffs +1", --11/(-6)
        hands={ name="ケカスカフス+1", augments={'MP+80','MND+12','Mag. Acc.+20',}},
        --ring1={name="Stikini Ring +1", bag="wardrobe3"},
        --ring2="Metamor. Ring +1",
        ring1={name="スティキニリング+1", bag="Wardrobe 2"},
        ring2={ name="メタモルリング+1", augments={'Path: A',}},
        back="黄昏の羽衣",
        waist="光輪の帯",
        --back="Twilight Cape",
        --waist="Hachirin-no-Obi",
        }

    --sets.midcast.CureMelee = sets.midcast.CureSolace

    sets.midcast.StatusRemoval = {
        main="ヤグルシュ",
        --sub="Chanter's Shield",
        sub={ name="玄武盾", augments={'"Cure" potency +5%','"Cure" spellcasting time -6%','MP+27',}},
        head={ name="ヴァニヤフード", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
        body="インヤガジュバ+2",
        hands={ name="ファナチクグローブ", augments={'MP+50','Healing magic skill +10','"Conserve MP"+7','"Fast Cast"+7',}},
        legs="アヤモコッシャレ+2",
        feet={ name="ケカスブーツ+1", augments={'Mag. Acc.+20','"Cure" potency +6%','"Fast Cast"+4',}},
        neck="オルンミラトルク",
        ear1="エンチャンピアス+1",
        ear2="ロケイシャスピアス",
        ring1="キシャールリング",
        ring2="ラハブリング",
        --head="Vanya Hood",
        --body="Inyanga Jubbah +2",
        --hands="Fanatic Gloves",
        --legs="Aya. Cosciales +2",
        --feet="Medium's Sabots",
        --neck="Orunmila's Torque",
        --ear1="Loquacious Earring",
        --ear2="Etiolation Earring",
        --ring1="Kishar Ring",
        --ring2="Weather. Ring +1",
        back=gear.WHM_FC_Cape,
        waist="エンブラサッシュ",
        }

    sets.midcast.Cursna = set_combine(sets.midcast.StatusRemoval, {
        main="ヤグルシュ",
        --sub={ name="玄武盾", augments={'"Cure" potency +5%','"Cure" spellcasting time -6%','MP+27',}},
        sub="トィエライエキュ+1",
        --body="Ebers Bliaud +1",
        head={ name="ヴァニヤフード", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
        body="ＥＢブリオー+1",
        hands={ name="ファナチクグローブ", augments={'MP+50','Healing magic skill +10','"Conserve MP"+7','"Fast Cast"+7',}},
        --hands="Fanatic Gloves", --15
        --legs="Th. Pant. +3", --21
        legs="ＴＥパンタロン+3",
        feet={ name="ヴァニヤクロッグ", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
        --feet="Vanya Clogs", --5
        --feet="Gende. Galosh. +1", --10
        neck="デビリスメダル", --15
        ear1="ビティフィクピアス",
        ear2="メイリピアス",
        ring1="ハオマリング", --15
        ring2="メネロスリング", --20
        --back=gear.WHM_FC_Cape, --25
        back={ name="メンディングケープ", augments={'Healing magic skill +10','Enha.mag. skill +8','Mag. Acc.+8',}},
        waist="ビショップサッシュ",
        })

    sets.midcast.Erase = set_combine(sets.midcast.StatusRemoval, {neck="クレリクトルク+2"})

    -- 110 total Enhancing Magic Skill; caps even without Light Arts
    sets.midcast['強化魔法'] = {
        main={ name="ガーダ", augments={'Enh. Mag. eff. dur. +6','"Mag.Atk.Bns."+12',}},
        --main="ベニフィクス"
        sub="アムラピシールド",
        head={ name="テルキネキャップ", augments={'Mag. Acc.+23','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
        body={ name="テルキネシャジュブ", augments={'Mag. Acc.+24','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
        --head=gear.Telchine_ENH_head,
        --body=gear.Telchine_ENH_body,
        hands="ダイナスティミトン",
        --legs=gear.Telchine_ENH_legs,
        legs={ name="テルキネブラコーニ", augments={'Mag. Acc.+25','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
        --feet="Theo. Duckbills +3",
        feet="ＴＥダックビル+3",
        neck="インカンタートルク",
        ear1="ミミルピアス",
        ear2="アンドアーピアス",
        ring1={name="スティキニリング+1", bag="Wardrobe 2"},
        ring2={name="スティキニリング+1", bag="Wardrobe 3"},
        back="フィフォレケープ+1",
        waist="オリンポスサッシュ",
        }

    sets.midcast.EnhancingDuration = {
        main={ name="ガーダ", augments={'Enh. Mag. eff. dur. +6','"Mag.Atk.Bns."+12',}},
        --main="ベニフィクス"
        sub="アムラピシールド",
        head={ name="テルキネキャップ", augments={'Mag. Acc.+23','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
        body={ name="テルキネシャジュブ", augments={'Mag. Acc.+24','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
        hands={ name="テルキネグローブ", augments={'Mag. Acc.+22','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
        legs={ name="テルキネブラコーニ", augments={'Mag. Acc.+25','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
        --head=gear.Telchine_ENH_head,
        --body=gear.Telchine_ENH_body,
        --hands=gear.Telchine_ENH_hands,
        --legs=gear.Telchine_ENH_legs,
        feet="ＴＥダックビル+3",
        waist="エンブラサッシュ",
        }

    sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration, {
        main="ボレラブンガ",
        sub="アムラピシールド",
        head="インヤガティアラ+2",
        body={ name="ＰＩブリオー+3", augments={'Enhances "Benediction" effect',}},
        --head={ name="テルキネキャップ", augments={'Mag. Acc.+23','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
        hands={ name="テルキネグローブ", augments={'Mag. Acc.+22','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
        legs={ name="テルキネブラコーニ", augments={'Mag. Acc.+25','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
        feet={ name="テルキネピガッシュ", augments={'Mag. Acc.+24','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
        --hands=gear.Telchine_ENH_hands,
        --legs=gear.Telchine_ENH_legs,
        --feet=gear.Telchine_ENH_feet,
        })

    sets.midcast.RegenDuration = set_combine(sets.midcast.EnhancingDuration, {
        --body=gear.Telchine_ENH_body,
        body={ name="テルキネシャジュブ", augments={'Mag. Acc.+24','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
        hands="ＥＢミトン+1",
        --legs="Th. Pant. +3",
        --feet="Theo. Duckbills +3",
        legs="ＴＥパンタロン+3",
        feet="ＴＥダックビル+3",
        })

    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {
        waist="ギシドゥバサッシュ",
        --back="Grapevine Cape",
        })

    sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {
        neck="ノデンズゴルゲット",
        waist="ジーゲルサッシュ",
        })

    sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
        main="バドースロッド",
        sub="アムラピシールド",
        ammo="ストンチタスラム+1",
        --hands="Regal Cuffs",
        ear1="ハラサズピアス",
        ear2="Magnetic Earring",
        ring1="フレキリング",
        ring2="エバネセンスリング",
        --waist="Emphatikos Rope",
        })

    sets.midcast.Auspice = set_combine(sets.midcast.EnhancingDuration, {
        feet="ＥＢダックビル+1",
        })

    sets.midcast.BarElement = set_combine(sets.midcast['強化魔法'], {
        main="ベニフィクス",
        sub="アムラピシールド",
        head="ＥＢキャップ+1",
        body="ＥＢブリオー+1",
        hands="ＥＢミトン+1",
        legs={ name="ＰＩパンタロン+3", augments={'Enhances "Afflatus Misery" effect',}},
        --legs="Piety Pantaln. +3",
        feet="ＥＢダックビル+1",
        })

    sets.midcast.BoostStat = set_combine(sets.midcast['強化魔法'], {
        --feet="Ebers Duckbills +1"
        feet="ＥＢダックビル+1",
        })

    sets.midcast.Protect = set_combine(sets.midcast.ConserveMP, sets.midcast.EnhancingDuration, {
        ring1="シェルターリング",
        })

    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Protect

    sets.midcast['神聖魔法'] = {
        main="ヤグルシュ",
        sub="アムラピシールド",
        ammo="ガストリタスラム+1",
        --head="Theophany Cap +3",
        head={ name="カイロンハット", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','"Fast Cast"+2','Mag. Acc.+15',}},
        body="ＴＥブリオー+3",
        hands={ name="ＰＩミトン+3", augments={'Enhances "Martyr" effect',}},
        legs={ name="カイロンホーズ", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','MND+5','Mag. Acc.+12','"Mag.Atk.Bns."+3',}},
        feet="ＴＥダックビル+3",
        neck="エーラペンダント",
        ear1="ディグニタリピアス",
        ear2="王将の耳飾り",
        ring1={name="スティキニリング+1", bag="Wardrobe 2"},
        ring2={name="スティキニリング+1", bag="Wardrobe 3"},
        --back="Aurist's Cape +1",
        back={ name="アラウナスケープ", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10',}},
        waist={ name="アキュイテベルト+1", augments={'Path: A',}},
        }

    sets.midcast.Banish = set_combine(sets.midcast['神聖魔法'], {
        main="デイブレイクワンド",
        sub="アムラピシールド",
        --head=empty;
        --body="Cohort Cloak +1",
        head={ name="カイロンハット", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','"Fast Cast"+2','Mag. Acc.+15',}},
        body="ＴＥブリオー+3",
        hands={ name="ファナチクグローブ", augments={'MP+50','Healing magic skill +10','"Conserve MP"+7','"Fast Cast"+7',}},
        legs={ name="ケカスタイツ+1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
        neck="サンクトネックレス",
        ear1="マリグナスピアス",
        ring1="フレキリング",
        ring2={name="スティキニリング+1", bag="Wardrobe 3"},
        waist="レフォシレストーン",
        })

    sets.midcast.Holy = sets.midcast.Banish

    sets.midcast['暗黒魔法'] = {
        main="マクセンチアス",
        sub="アムラピシールド",
        ammo="ペムフレドタスラム",
        head="妖蟲の髪飾り+1",
        body="ＴＥブリオー+3",
        hands="ＴＥミトン+3",
        legs={ name="カイロンホーズ", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','MND+5','Mag. Acc.+12','"Mag.Atk.Bns."+3',}},
        feet="ＴＥダックビル+3",
        neck="エーラペンダント",
        ear1="マリグナスピアス",
        ear2="Mani Earring",
        ring1="エバネセンスリング",
        ring2="アルコンリング",
        --back="Aurist's Cape +1",
        back={ name="アラウナスケープ", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10',}},
        waist="風鳥の帯",
        }

    -- Custom spell classes
    sets.midcast.MndEnfeebles = {
        main="ヤグルシュ",
        sub="アムラピシールド",
        ammo="ペムフレドタスラム",
        --head=empty;
        --body="Cohort Cloak +1",
        head={ name="カイロンハット", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','"Fast Cast"+2','Mag. Acc.+15',}},
        body="ＴＥブリオー+3",
        --hands="Regal Cuffs",
        hands={ name="ケカスカフス+1", augments={'MP+80','MND+12','Mag. Acc.+20',}},
        legs={ name="カイロンホーズ", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','MND+5','Mag. Acc.+12','"Mag.Atk.Bns."+3',}},
        feet="ＴＥダックビル+3",
        neck="エーラペンダント",
        ear1="マリグナスピアス",
        ear2="Vor Earring",
        ring1="キシャールリング",
        ring2={name="スティキニリング+1", bag="wardrobe3"},
        back={ name="アラウナスケープ", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10',}},
        waist="ルーミネリサッシュ",
        }

    sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, {
        waist={ name="アキュイテベルト+1", augments={'Path: A',}},
        })

    sets.midcast.Dispelga = set_combine(sets.midcast.IntEnfeebles, {main="デイブレイクワンド", sub="アムラピシールド"})

    sets.midcast.Impact = {
        main="マクセンチアス",
        sub="アムラピシールド",
        head=empty,
        body="トワイライトプリス",
        hands="レテクバングル+1",
        legs="ＴＥパンタロン+3",
        feet="ＴＥダックビル+3",
        ring1="フレキリング",
        ring2="アルコンリング",
        }

    -- Initializes trusts at iLvl 119
    sets.midcast.Trust = sets.precast.FC

    -- Sets to return to when not performing an action.

    -- Resting sets
    sets.resting = {
        --main="Chatoyant Staff",
        waist="神術帯+1",
        }

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {
        main={ name="アスクレピウス", augments={'Path: C',}},
        sub="玄冥盾",
        ammo="ホミリアリ",
        --head="Volte Beret",
        head={ name="カイロンハット", augments={'Rng.Atk.+24','Mag. Acc.+22 "Mag.Atk.Bns."+22','"Refresh"+2','Accuracy+8 Attack+8',}},
        --body="Piety Briault +3",
        body={ name="ケカスブリオー+1", augments={'MP+80','"Cure" potency +6%','"Conserve MP"+7',}},
        --hands="Raetic Bangles +1",
        --legs="Volte Brais",
        hands={ name="カイロングローブ", augments={'DEX+4','Phys. dmg. taken -2%','"Refresh"+2','Mag. Acc.+10 "Mag.Atk.Bns."+10',}},
        legs={ name="カイロンホーズ", augments={'Accuracy+6','Pet: Mag. Acc.+22','"Refresh"+2','Mag. Acc.+4 "Mag.Atk.Bns."+4',}},
        --feet="Inyan. Crackows +2",
        feet={ name="カイロンスリッパー", augments={'Pet: Mag. Acc.+29','Accuracy+25','"Refresh"+2','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
        --neck="Bathy Choker +1",
        neck={ name="クレリクトルク+2", augments={'Path: A',}},
        --ear1="Eabani Earring",
        --ear2="Sanare Earring",
        ear1="ハーティーピアス",
        ear2="驕慢の耳",
        ring1={name="スティキニリング+1", bag="wardrobe2"},
        ring2="ＷＬリング+1",
        --back="Moonlight Cape",
        back={ name="アラウナスケープ", augments={'MP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10',}},
        waist="風鳥の帯",
        --waist="Carrier's Sash",
        }

    sets.idle.DT = set_combine(sets.idle, {
        --main="Daybreak",
        --sub="Genmei Shield", --10/0
        main={ name="アスクレピウス", augments={'Path: C',}},
        sub="玄冥盾",
        ammo="ストンチタスラム+1", --3/3
        head="アヤモツッケット+2", --3/3
        hands="アヤモマノポラ+2", --4/4
        neck="ロリケートトルク+1", --6/6
        ear1="オノワイヤリング+1", --3/5
        ring1="ゼラチナスリング+1", --7/(-1)
        ring2="守りの指輪", --10/10
        --back="Moonlight Cape", --6/6
        back={ name="アラウナスケープ", augments={'MP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10',}},
        --waist="Carrier's Sash",
        waist="風鳥の帯",
        })

    sets.idle.MEva = set_combine(sets.idle.DT, {
        --main="Daybreak",
        main={ name="アスクレピウス", augments={'Path: C',}},
        sub="玄冥盾",
        --sub="Genmei Shield",
        ammo="ストンチタスラム+1",
        head="インヤガティアラ+2",
        body="インヤガジュバ+2",
        --hands="Raetic Bangles +1",
        legs="インヤガシャルワ+2",
        feet="インヤガクラッコ+2",
        --neck="Warder's Charm +1",
        neck="ロリケートトルク+1",
        ear1="エアバニピアス",
        ear2="驕慢の耳",
        ring1="Purity Ring",
        ring2="Inyanga Ring",
        back=gear.WHM_FC_Cape,
        --waist="Carrier's Sash",
        waist="風鳥の帯",
        })

    sets.idle.Town = set_combine(sets.idle, {
        main="ヤグルシュ",
        sub="アムラピシールド",
        head={ name="ケカスミトラ+1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
        body={ name="ケカスブリオー+1", augments={'MP+80','"Cure" potency +6%','"Conserve MP"+7',}},
        hands={ name="ケカスカフス+1", augments={'MP+80','MND+12','Mag. Acc.+20',}},
        legs={ name="ケカスタイツ+1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
        feet={ name="ケカスブーツ+1", augments={'Mag. Acc.+20','"Cure" potency +6%','"Fast Cast"+4',}},
        neck={ name="クレリクトルク+2", augments={'Path: A',}},
        ear1="朝露の耳飾",
        ear2="王将の耳飾り",
        })

    -- Defense sets

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.Kiting = {feet="ヘラルドゲートル"}
    sets.latent_refresh = {waist="風鳥の帯"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Basic set for if no TP weapon is defined.
    sets.engaged = {
        main="ヤグルシュ",
        sub="アムラピシールド",
        --head="Blistering Sallet +1",
        head="アヤモツッケット+2",
        body="アヤモコラッツァ+2",
        --hands=gear.Telchine_STP_hands,
        hands="アヤモマノポラ+2",
        legs="アヤモコッシャレ+2",
        --feet=gear.Chironic_QA_feet,
        feet="アヤモガンビエラ+2",
        neck="Combatant's Torque",
        ear1="セサンスピアス",
        ear2="テロスピアス",
        ring1={name="シーリチリング+1", bag="wardrobe7"},
        ring2={name="シーリチリング+1", bag="wardrobe8"},
        --back=gear.WHM_DA_Cape,
        back={ name="アラウナスケープ", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10',}},
        waist="ウィンバフベルト+1",
        }

    sets.engaged.Acc = set_combine(sets.engaged, {
        --hands="Gazu Bracelet +1",
        head="アヤモツッケット+2",
        feet="アヤモガンビエラ+2",
        waist="ウィンバフベルト+1",
        --feet="Volte Boots",
        --waist="Olseni Belt",
        })

    sets.engaged.DW = {
        main="ヤグルシュ",
        --sub="C. Palug Hammer",
        sub="ミョルニル",
        --head="Blistering Sallet +1",
        head="アヤモツッケット+2",
        body="アヤモコラッツァ+2",
        --hands=gear.Telchine_STP_hands,
        hands="アヤモマノポラ+2",
        legs="アヤモコッシャレ+2",
        --feet=gear.Chironic_QA_feet,
        feet="アヤモガンビエラ+2",
        --hands=gear.Telchine_STP_hands,
        --feet=gear.Chironic_QA_feet,
        neck="Combatant's Torque",
        ear1="セサンスピアス",
        ear2="素破の耳", --5
        ring1={name="シーリチリング+1", bag="wardrobe7"},
        ring2={name="シーリチリング+1", bag="wardrobe8"},
        --back=gear.WHM_DA_Cape,
        back={ name="アラウナスケープ", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10',}},
        --waist="Shetal Stone", --6
        waist="ウィンバフベルト+1",
        }

    sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {
        --sub="Sindri",
        --hands="Gazu Bracelet +1",
        --feet="Volte Boots",
        sub="ミョルニル",
        --head="Blistering Sallet +1",
        head="アヤモツッケット+2",
        feet="アヤモガンビエラ+2",
        })

    sets.engaged.Aftermath = {
        --head="Aya. Zucchetto +2",
        --hands=gear.Telchine_STP_hands,
        --legs="Aya. Cosciales +2",
        --feet=gear.Telchine_STP_feet,
        head="アヤモツッケット+2",
        body="アヤモコラッツァ+2",
        --hands=gear.Telchine_STP_hands,
        hands="アヤモマノポラ+2",
        legs="アヤモコッシャレ+2",
        --feet=gear.Chironic_QA_feet,
        feet="アヤモガンビエラ+2",
        ring1={name="Chirich Ring +1", bag="wardrobe7"},
        ring2={name="Chirich Ring +1", bag="wardrobe8"},
        --back=gear.WHM_STP_Cape,
        back={ name="アラウナスケープ", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10',}},
        }

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['女神の愛撫'] = {hands="ＥＢミトン+1", back="メンディングケープ"}
    sets.buff['デヴォーション'] = {head="ＰＩキャップ+3"}
    sets.buff.Sublimation = {waist="エンブラサッシュ"}

    sets.buff.Doom = {
        neck="  ", --20
        --ring1={name="Eshmun's Ring", bag="wardrobe3"}, --20
        --ring2={name="Eshmun's Ring", bag="wardrobe4"}, --20
        waist="ギシドゥバサッシュ", --10
        }

    sets.Obi = {waist="八輪の帯"}
    -- sets.CP = {back="Mecisto. Mantle"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.name == "パラナ" and buffactive['麻痺'] then
        -- no gear swaps if we're paralyzed, to avoid blinking while trying to remove it.
        eventArgs.handled = true
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.name == 'インパクト' then
        equip(sets.precast.FC.Impact)
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
    if spellMap == 'StatusRemoval' and buffactive['女神の愛撫'] then
        equip(sets.buff['女神の愛撫'])
    end
    if spellMap == 'Banish' or spellMap == 'Holy' then
        if (world.weather_element == 'Light' or world.day_element == 'Light') then
            equip(sets.Obi)
        end
    end
    if spell.skill == '強化魔法' then
        if classes.NoSkillSpells:contains(spell) then
            equip(sets.midcast.EnhancingDuration)
            if spellMap == 'Refresh' then
                equip(sets.midcast.Refresh)
            end
        end
        if spellMap == "Regen" and state.RegenMode.value == 'Duration' then
            equip(sets.midcast.RegenDuration)
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.name == "スリプルII" then
            send_command('@timers c "スリプルII ['..spell.target.name..']" 90 down spells/00259.png')
        elseif spell.name == "スリプル" or spell.name == "スリプガ" then -- Sleep & Sleepga Countdown --
            send_command('@timers c "スリプル ['..spell.target.name..']" 60 down spells/00253.png')
        elseif spell.name == "リポーズ" then
            send_command('@timers c "リポーズ ['..spell.target.name..']" 90 down spells/00098.png')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

function job_buff_change(buff,gain)
  if string.find(buff, '机上演習') then
    if state.Buff['机上演習:蓄積中'] then
      handle_equipping_gear(player.status)
    end
  end
    --if buff == "机上演習:蓄積中" then
      --handle_equipping_gear(player.status)
    --end

    if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            --send_command('@input /p Doomed.')
            disable('ring1','ring2','waist')
        else
            enable('ring1','ring2','waist')
            handle_equipping_gear(player.status)
        end
    end

end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub')
    else
        enable('main','sub')
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
    check_gear()
    update_combat_form()
    check_moving()
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
    update_sublimation()
end

function update_combat_form()
    if DW == true then
        state.CombatForm:set('DW')
    elseif DW == false then
        state.CombatForm:reset()
    end
end

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
--      if (default_spell_map == 'Cure' or default_spell_map == 'Curaga') and player.status == 'Engaged' then
--          return "CureMelee"
        if default_spell_map == 'ケアル' then
            if buffactive['ハートオブソラス'] then
                if (world.weather_element == 'Light' or world.day_element == 'Light') then
                    return "CureSolaceWeather"
                else
                    return "CureSolace"
              end
            else
                if (world.weather_element == 'Light' or world.day_element == 'Light') then
                    return "CureWeather"
                else
                    return "CureNormal"
              end
            end
        elseif default_spell_map == 'ケアルガ' then
            if (world.weather_element == 'Light' or world.day_element == 'Light') then
                return "CuragaWeather"
            else
                return "CuragaNormal"
            end
        elseif spell.skill == "弱体魔法" then
            if spell.type == "白魔法" then
                return "MndEnfeebles"
            else
                return "IntEnfeebles"
            end
        end
    end
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if buffactive['アフターマス: Lv.3'] and player.equipment.main == "ヤグルシュ" then
        meleeSet = set_combine(meleeSet, sets.engaged.Aftermath)
    end

    return meleeSet
end

function customize_idle_set(idleSet)
    if state.Buff['机上演習:蓄積中'] then
        idleSet = set_combine(idleSet, sets.buff.Sublimation)
    end
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
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

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local c_msg = state.CastingMode.value

    local r_msg = state.RegenMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(060, '| Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060).. ' Regen: ' ..string.char(31,001)..r_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function job_self_command(cmdParams, eventArgs)
    gearinfo(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'scholar' then
        handle_strategems(cmdParams)
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'nuke' then
        handle_nuking(cmdParams)
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'barelement' then
        send_command('@input /ma '..windower.to_shift_jis(state.BarElement.value)..' <me>')
    elseif cmdParams[1]:lower() == 'barstatus' then
        send_command('@input /ma '..windower.to_shift_jis(state.BarStatus.value)..' <me>')
    elseif cmdParams[1]:lower() == 'boostspell' then
        send_command('@input /ma '..windower.to_shift_jis(state.BoostSpell.value)..' <me>')
    end

    gearinfo(cmdParams, eventArgs)
end

function gearinfo(cmdParams, eventArgs)
    if cmdParams[1] == 'gearinfo' then
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

function update_sublimation()
    state.Buff['机上演習:蓄積中'] = buffactive['机上演習:蓄積中'] or false
end

-- General handling of strategems in an Arts-agnostic way.
-- Format: gs c scholar <strategem>
function handle_strategems(cmdParams)
    -- cmdParams[1] == 'scholar'
    -- cmdParams[2] == strategem to use

    if not cmdParams[2] then
        add_to_chat(123,'Error: No strategem command given.')
        return
    end
    local strategem = cmdParams[2]:lower()

    if strategem == 'light' then
        if buffactive['白のグリモア'] then
            send_command('input /ja '..windower.to_shift_jis("白の補遺")..' <me>')
        elseif buffactive['白の補遺'] then
            add_to_chat(122,'Error: Addendum: White is already active.')
        else
            send_command('input /ja'..windower.to_shift_jis("白のグリモア")..' <me>')
        end
    elseif strategem == 'dark' then
        if buffactive['黒のグリモア'] then
            send_command('input /ja '..windower.to_shift_jis("黒の補遺")..' <me>')
        elseif buffactive['黒の補遺'] then
            add_to_chat(122,'Error: Addendum: Black is already active.')
        else
            send_command('input /ja '..windower.to_shift_jis("黒のグリモア")..' <me>')
        end
    elseif buffactive['白のグリモア'] or buffactive['白の補遺'] then
        if strategem == 'cost' then
            send_command('input /ja '..windower.to_shift_jis("簡素清貧の章")..' <me>')
        elseif strategem == 'speed' then
            send_command('input /ja '..windower.to_shift_jis("電光石火の章")..' <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja '..windower.to_shift_jis("女神降臨の章")..' <me>')
        elseif strategem == 'addendum' then
            send_command('input /ja '..windower.to_shift_jis("白の補遺")..' <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    elseif buffactive['黒のグリモア']  or buffactive['黒の補遺'] then
        if strategem == 'cost' then
            send_command('input /ja '..windower.to_shift_jis("勤倹小心の章")..' <me>')
        elseif strategem == 'speed' then
            send_command('input /ja '..windower.to_shift_jis("疾風迅雷の章")..' <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja '..windower.to_shift_jis("精霊光来の章")..' <me>')
        elseif strategem == 'addendum' then
            send_command('input /ja '..windower.to_shift_jis("黒の補遺")..' <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    else
        add_to_chat(123,'No arts has been activated yet.')
    end
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
    end
)

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 1)
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end