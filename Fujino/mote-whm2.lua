-- hb buff <me> Firestorm
-- hb cancelbuff 
-- Windstorm
-- Barwatera
include('myexport')
function get_sets()
    set_language('japanese')
    
    sets.precast = {}
    sets.precast.ws = {}
    sets.midcast = {}
    sets.aftercast = {}
    
    is_doom = false
    
    sets.sa_na = T{'ポイゾナ', 'パラナ', 'ブライナ', 'サイレナ', 'カーズナ', 'ウィルナ', 'ストナ', 'イレース'}
    sets.addi = T{'アディバイト', 'アディマイン', 'アディカリス', 'アディアジル', 'アディスト', 'アディイン', 'アディデック'}
    sets.ba = T{'バストンラ', 'バウォタラ', 'バエアロラ', 'バファイラ', 'バブリザラ', 'バサンダラ','バストン', 'バウォタ', 'バエアロ', 'バファイ', 'バブリザ', 'バサンダ'}

    -- 女神の愛撫
    sets.caress = {
        hands="ＥＢミトン+1",
        back={ name="メンディングケープ", augments={'Healing magic skill +9','Enha.mag. skill +9',}},
    }
    
    sets.precast.fc = {
        ammo="インカントストーン",
        head={ name="ヴァニヤフード", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
        body="インヤガジュバ+2",
        hands={ name="ＧＥゲージ+1", augments={'Phys. dmg. taken -4%','Magic dmg. taken -4%','"Cure" spellcasting time -5%',}},
        legs="アヤモコッシャレ+2",
        feet={ name="テルキネピガッシュ", augments={'Mag. Evasion+23','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
        neck="クレリクトルク+2",
        waist="ニヌルタサッシュ",
        ear1="エテオレートピアス",
        ear2="ロケイシャスピアス",
        ring1="キシャールリング",
        ring2="プロリクスリング",
        --back={ name="アラウナスケープ", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}},
        back={ name="アラウナスケープ", augments={'MP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10',}},
    }

    sets.precast.fc_cure = {
        body="インヤガジュバ+2",
        hands={ name="ＧＥゲージ+1", augments={'Phys. dmg. taken -4%','Magic dmg. taken -4%','"Cure" spellcasting time -5%',}},
        legs="ＥＢパンタロン+1",
        feet={ name="ヴァニヤクロッグ", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
        ring2="プロリクスリング",
        --back={ name="アラウナスケープ", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}},
        back={ name="アラウナスケープ", augments={'MP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10',}},
    }
    
    sets.precast.na = {
        main="ヤグルシュ",
        ammo="インカントストーン",
        head="ＥＢキャップ+1",
        body={ name="テルキネシャジュブ", augments={'Mag. Evasion+23','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
        hands={ name="ＧＥゲージ+1", augments={'Phys. dmg. taken -4%','Magic dmg. taken -4%','"Cure" spellcasting time -5%',}},
        legs="ＥＢパンタロン+1",
        feet={ name="テルキネピガッシュ", augments={'Mag. Evasion+23','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
        neck="クレリクトルク+2",
        waist="ニヌルタサッシュ",
        ear1="エテオレートピアス",
        ear2="ロケイシャスピアス",
        ring1="守りの指輪",
        ring2="プロリクスリング",
        --back={ name="アラウナスケープ", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}},
        back={ name="アラウナスケープ", augments={'MP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10',}},
    }
    
    sets.precast.doom = {
        main="ガンバンテイン",
        ammo="ヘイストピニオン+1",
        head={ name="ヴァニヤフード", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
        body="ＥＢブリオー+1",
        hands={ name="ファナチクグローブ", augments={'MP+50','Healing magic skill +10','"Conserve MP"+7','"Fast Cast"+7',}},
        legs="ＴＥパンタロン+3",
        feet={ name="ヴァニヤクロッグ", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
        neck="デビリスメダル",
        waist="ギシドゥバサッシュ",
        ear1="ビティフィクピアス",
        ear2="メイリピアス",
        ring1="メネロスリング",
        ring2="ハオマリング",
        --back={ name="アラウナスケープ", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}},
        back={ name="アラウナスケープ", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10',}},
    }
    
    sets.precast.ws.multi = {
        ammo="アマークラスター",
        head="アヤモツッケット+2",
        body="アヤモコラッツァ+2",
        hands="アヤモマノポラ+2",
        legs="アヤモコッシャレ+2",
        feet="アヤモガンビエラ+2",
        neck="フォシャゴルゲット",
        waist="フォシャベルト",
        ear1="セサンスピアス",
        --ear2={ name="胡蝶のイヤリング", augments={'Accuracy+4','TP Bonus +250',}},
        ear2={ name="胡蝶のイヤリング", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        ring1="守りの指輪",
        ring2="イラブラットリング",
        --back={ name="アラウナスケープ", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dual Wield"+10','Damage taken-5%',}},
        back={ name="アラウナスケープ", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10',}},
    }

    sets.precast.ws.mnd = {
        ammo="アマークラスター",
        head={ name="ＰＩキャップ+3", augments={'Enhances "Devotion" effect',}},
        body={ name="ＰＩブリオー+3", augments={'Enhances "Benediction" effect',}},
        hands={ name="ＰＩミトン+3", augments={'Enhances "Martyr" effect',}},
        legs={ name="ＰＩパンタロン+3", augments={'Enhances "Afflatus Misery" effect',}},
        feet={ name="ＰＩダックビル+3", augments={'Enhances "Afflatus Solace" effect',}},
        neck="フォシャゴルゲット",
        waist="フォシャベルト",
        ear1="王将の耳飾り",
        --ear2={ name="胡蝶のイヤリング", augments={'Accuracy+4','TP Bonus +250',}},
        ear2={ name="胡蝶のイヤリング", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        ring1={ name="メタモルリング+1", augments={'Path: A',}},
        ring2="イラブラットリング",
        --back={ name="アラウナスケープ", augments={'MND+20','Accuracy+20 Attack+20','MND+10','Weapon skill damage +10%','Damage taken-5%',}},
        back={ name="アラウナスケープ", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10',}},
    }

    sets.precast.ws["ミスティックブーン"] = set_combine(sets.precast.ws.mnd, {neck="クレリクトルク+2", waist="グルンフェルロープ",})
    sets.midcast.enhance_duration = {
        --main={ name="ガーダ", augments={'Enh. Mag. eff. dur. +5','VIT+3','Mag. Acc.+6',}},
        main={ name="ガーダ", augments={'Enh. Mag. eff. dur. +6','"Mag.Atk.Bns."+12',}},
        sub="アムラピシールド",
        head={ name="テルキネキャップ", augments={'Mag. Evasion+23','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
        body={ name="テルキネシャジュブ", augments={'Mag. Evasion+24','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
        hands={ name="テルキネグローブ", augments={'Mag. Evasion+22','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
        legs={ name="テルキネブラコーニ", augments={'Mag. Evasion+24','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
        feet="ＴＥダックビル+3",
        waist="ニヌルタサッシュ",
    }
    
    sets.midcast.cure = {
        main={ name="クェラーロッド", augments={'MP+80','"Cure" potency +15%','Enmity-5',}},
        sub="玄冥盾",
        ammo="ペムフレドタスラム",
        head={ name="ＧＥカウビーン+1", augments={'Phys. dmg. taken -4%','Magic dmg. taken -4%','"Cure" potency +8%',}},
        body="ＥＢブリオー+1",
        hands="ＴＥミトン+3",
        legs="ＥＢパンタロン+1",
        feet={ name="ＰＩダックビル+3", augments={'Enhances "Afflatus Solace" effect',}},
        neck={ name="クレリクトルク+2", augments={'Path: A',}},
        waist="ニヌルタサッシュ",
        ear1="朝露の耳飾",
        ear2="ノーヴィアピアス",
        ring1="守りの指輪",
        ring2={ name="ゼラチナスリング+1", augments={'Path: A',}},
        --back={ name="アラウナスケープ", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}},
        back={ name="アラウナスケープ", augments={'MP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10',}},
    }
    
    sets.midcast.protect = set_combine(sets.midcast.enhance_duration, {ear1="ブラキュラピアス",})
    sets.midcast.shell = set_combine(sets.midcast.enhance_duration, {ear1="ブラキュラピアス",})
    sets.midcast.auspice = set_combine(sets.midcast.enhance_duration, {feet="ＥＢダックビル+1",})
    sets.midcast.rejen = set_combine(sets.midcast.enhance_duration, {main="ボレラブンガ", head="インヤガティアラ+2", body="ＰＩブリオー+3", hands="ＥＢミトン+1", legs="ＴＥパンタロン+3",})
    sets.midcast.skin = set_combine(sets.midcast.enhance_duration, {legs="シェダルサラウィル", neck='ノデンズゴルゲット', left_ear='アースクライピアス', waist="ジーゲルサッシュ",})
    sets.midcast.aquaveil = set_combine(sets.midcast.enhance_duration, {main="バドースロッド", legs="シェダルサラウィル"})
    
    sets.midcast.ba = {
        main="ベニフィクス",
        sub="アムラピシールド",
        ammo="インカントストーン",
        head={ name="テルキネキャップ", augments={'Mag. Evasion+25','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
        body="ＥＢブリオー+1",
        hands="ダイナスティミトン",
        legs={ name="ＰＩパンタロン+3", augments={'Enhances "Afflatus Misery" effect',}},
        feet="ＴＥダックビル+3",
        neck="インカンタートルク",
        waist="オリンポスサッシュ",
        ear1="エテオレートピアス",
        ear2="ミミルピアス",
        ring1={ name="スティキニリング+1", bag={'wardrobe 2',}},
        ring2={ name="スティキニリング+1", bag={'wardrobe 3',}},
        --back={ name="アラウナスケープ", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}},
        back={ name="アラウナスケープ", augments={'MP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10',}},
    }
    
    sets.midcast.addi = {
        --main={ name="ガーダ", augments={'Enh. Mag. eff. dur. +5','VIT+3','Mag. Acc.+6',}},
        main={ name="ガーダ", augments={'Enh. Mag. eff. dur. +6','"Mag.Atk.Bns."+12',}},
        sub="アムラピシールド",
        ammo="インカントストーン",
        head={ name="テルキネキャップ", augments={'Mag. Evasion+25','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
        body={ name="テルキネシャジュブ", augments={'Mag. Evasion+23','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
        hands="ダイナスティミトン",
        legs={ name="テルキネブラコーニ", augments={'Mag. Evasion+24','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
        feet="ＴＥダックビル+3",
        neck="インカンタートルク",
        waist="オリンポスサッシュ",
        ear1="アンドアーピアス",
        ear2="ミミルピアス",
        ring1={ name="スティキニリング+1", bag={'wardrobe 2',}},
        ring2={ name="スティキニリング+1", bag={'wardrobe 3',}},
        back={ name="メンディングケープ", augments={'Healing magic skill +10','Enha.mag. skill +8','Mag. Acc.+8',}},
        --back={ name="メンディングケープ", augments={'Healing magic skill +9','Enha.mag. skill +9',}},
    }
    
    sets.midcast.magic_acc = {
        main="マクセンチアス",
        sub="アムラピシールド",
        ammo="ペムフレドタスラム",
        --head="ＴＥキャップ+2",
        head={ name="カイロンハット", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','"Fast Cast"+2','Mag. Acc.+15',}},
        body="ＴＥブリオー+3",
        hands="ＰＩミトン+3",
        --legs={ name="カイロンホーズ", augments={'Mag. Acc.+30','"Fast Cast"+4','MND+15','"Mag.Atk.Bns."+6',}},
        legs={ name="カイロンホーズ", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','MND+5','Mag. Acc.+12','"Mag.Atk.Bns."+3',}},
        feet="ＴＥダックビル+3",
        neck="エーラペンダント",
        waist="エスカンストーン",
        ear1="マリグナスピアス",
        ear2="王将の耳飾り",
        ring1={ name="スティキニリング+1", bag={'wardrobe 2',}},
        ring2={ name="スティキニリング+1", bag={'wardrobe 3',}},
        --back={ name="アラウナスケープ", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}},
        back={ name="アラウナスケープ", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10',}},
    }
    
    sets.aftercast.idle = {
        main="ボレラブンガ",
        sub="玄冥盾",
        ammo="ホミリアリ",
        head="インヤガティアラ+2",
        body="シャマシュローブ",
        hands="インヤガダスタナ+2",
        legs="インヤガシャルワ+2",
        feet="インヤガクラッコ+2",
        neck="ロリケートトルク+1",
        waist="キャリアーサッシュ",
        ear1="エテオレートピアス",
        ear2="驕慢の耳",
        ring1="守りの指輪",
        ring2="シュネデックリング",
        --back={ name="アラウナスケープ", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}},
        back={ name="アラウナスケープ", augments={'MP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10',}},
    }
    
    sets.aftercast.melee = {
        main="マクセンチアス",
        ammo="アマークラスター",
        head="アヤモツッケット+2",
        body="アヤモコラッツァ+2",
        hands="アヤモマノポラ+2",
        legs="アヤモコッシャレ+2",
        feet="アヤモガンビエラ+2",
        neck="ロリケートトルク+1",
        waist="グルンフェルロープ",
        ear1="セサンスピアス",
        ear2="ブルタルピアス",
        ring1="守りの指輪",
        ring2="イラブラットリング",
        --back={ name="アラウナスケープ", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dual Wield"+10','Damage taken-5%',}},
        back={ name="アラウナスケープ", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10',}},
    }

    -- マクロのブック, セット変更
    send_command('input /macro book 2; wait 0.5; input /macro set 10; wait 0.5; input /si whm; wait 0.5; input /lockstyleset 5 echo;')
    
end

function precast(spell)
    local set_equip = nil
    
    -- windower.add_to_chat(123, spell.name)
    -- windower.add_to_chat(123, spell.type)
    -- windower.add_to_chat(123, spell.skill)
    
    if string.find(spell.name, 'ケアル') then
        set_equip = sets.precast.fc_cure
    elseif sets.sa_na:contains(spell.name) then
        if spell.name == 'カーズナ' and is_doom == true then
            set_equip = sets.precast.doom
            if S{'忍','踊'}:contains(player.sub_job) then
                set_equip = set_combine(sets.precast.doom, {main="ヤグルシュ", sub="ガンバンテイン"})
            end
            is_doom = false
        else
            if buffactive['女神の愛撫'] then
                set_equip = set_combine(sets.precast.na, sets.caress)
            else
                set_equip = sets.precast.na
            end
        end
    elseif spell.skill == '回復魔法' then
        set_equip = set_combine(sets.precast.fc, {legs="ＥＢパンタロン+1",})
    elseif spell.skill == '強化魔法' then
        set_equip = set_combine(sets.precast.fc, {waist="ジーゲルサッシュ"})
    elseif string.find(spell.type, 'Magic') then
        set_equip = sets.precast.fc
    elseif spell.name == 'デヴォーション' then
        set_equip = {head="ＰＩキャップ+3"}
    elseif spell.name == 'マーター' then
        set_equip = {hands="ＰＩミトン+3"}
    elseif spell.name == '女神の祝福' then
        set_equip = {body="ＰＩブリオー+3"}
    elseif spell.type == 'WeaponSkill' then
        if sets.precast.ws[spell.name] then
            set_equip = sets.precast.ws[spell.name]
        else
            set_equip = sets.precast.ws.mnd
        end
    elseif spell.type == 'Trust' then
        set_equip = sets.precast.fc
    elseif spell.type == 'Ninjutsu' then
        set_equip = sets.precast.fc
    end
    
    if set_equip then
        equip(set_equip)
    end
end

function midcast(spell)
    local set_equip = nil
    
    if string.find(spell.name, 'ケアルガ') or string.find(spell.name, 'ケアルラ')then
        if buffactive['極光の陣'] or buffactive['極光の陣II'] then
            set_equip = set_combine(sets.midcast.cure, {body="ＴＥブリオー+3", waist="光輪の帯"})
        else
            set_equip = set_combine(sets.midcast.cure, {body="ＴＥブリオー+3",})
        end
    elseif string.find(spell.name, 'ケアル') or spell.name == 'フルケア' then
        if buffactive['極光の陣'] or buffactive['極光の陣II'] then
            set_equip = set_combine(sets.midcast.cure, {waist="光輪の帯"})
        else
            set_equip = sets.midcast.cure
        end
    elseif string.find(spell.name, 'プロテ') then
        set_equip = sets.midcast.protect
    elseif string.find(spell.name, 'シェル') then
        set_equip = sets.midcast.shell
    elseif string.find(spell.name, 'リジェネ') then
        set_equip = sets.midcast.rejen
    elseif spell.name == 'オースピス' then
        set_equip = sets.midcast.auspice
    elseif spell.name == 'ストンスキン' then
        set_equip= sets.midcast.skin
    elseif spell.name == 'アクアベール' then
        set_equip = sets.midcast.aquaveil
    elseif sets.addi:contains(spell.name) then
        set_equip = sets.midcast.addi
    elseif sets.ba:contains(spell.name) then
        set_equip = sets.midcast.ba
    elseif string.find(spell.name, 'デジョン') or string.find(spell.name, 'テレポ') or string.find(spell.name, 'リコール') or spell.name == 'リトレース' or spell.name == 'エスケプ' then
        set_equip = {waist="ニヌルタサッシュ",}
    elseif spell.skill == '強化魔法' and spell.name ~= 'イレース' then
        set_equip = sets.midcast.enhance_duration
    elseif spell.skill == '弱体魔法' then
        set_equip = sets.midcast.magic_acc
    elseif spell.skill == '神聖魔法' then
        if spell.name == 'リポーズ' then
            set_equip = sets.midcast.magic_acc
        else
            set_equip = sets.midcast.magic_acc
        end
    end
    
    if set_equip then
        equip(set_equip)
    end
end

function aftercast(spell)
    local set_equip = nil
    
    if player.status == 'Engaged' then
        set_equip = sets.aftercast.melee
    else
        set_equip = sets.aftercast.idle
    end
    
    if set_equip then
        equip(set_equip)
    end
end

function status_change(new, old)
    local set_equip = nil
    
    if new == 'Idle' then
        set_equip = sets.aftercast.idle
    elseif new == 'Engaged' then
        set_equip = sets.aftercast.melee
    end
    
    if set_equip then
        equip(set_equip)
    end
end

function self_command(command)
    if command == 'doom' then
        is_doom = not is_doom
        windower.add_to_chat(122, '---> カーズナ+装備: '..tostring(is_doom))
    end
end