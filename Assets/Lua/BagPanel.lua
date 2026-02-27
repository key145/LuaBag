BagPanel={}

BagPanel.panelObj=nil
BagPanel.equipTog=nil
BagPanel.itemTog=nil
BagPanel.gemTog=nil
BagPanel.content=nil
BagPanel.closeBtn=nil

BagPanel.nowType=-1

BagPanel.items={}

function BagPanel:Init()
    if self.panelObj==nil then
        self.panelObj = ABMgr:LoadRes("ui","BagPanel",typeof(GameObject))
        self.panelObj.transform:SetParent(Canvas,false)

        local toggleGroup=self.panelObj.transform:Find("ToggleGroup")
        self.equipTog=toggleGroup:Find("EquipTog"):GetComponent(typeof(Toggle))
        self.itemTog=toggleGroup:Find("ItemTog"):GetComponent(typeof(Toggle))
        self.gemTog=toggleGroup:Find("GemTog"):GetComponent(typeof(Toggle))

        self.closeBtn=self.panelObj.transform:Find("CloseBtn"):GetComponent(typeof(Button))
        self.content=self.panelObj.transform:Find("SVBag"):Find("Viewport"):Find("Content")

        self.closeBtn.onClick:AddListener(function()
            self:HidePanel()
        end)

        self.equipTog.onValueChanged:AddListener(function(value)
            if value==true then
                self:ToggleValueChange(1)
            end
        end)

        self.itemTog.onValueChanged:AddListener(function(value)
            if value==true then
                self:ToggleValueChange(2)
            end
        end)

        self.gemTog.onValueChanged:AddListener(function(value)
            if value==true then
                self:ToggleValueChange(3)
            end
        end)
    end
end

function BagPanel:ShowPanel()
    self:Init()
    self.panelObj:SetActive(true)
    if self.nowType==-1 then
        self:ToggleValueChange(1)
    end
end

function BagPanel:HidePanel()
    self.panelObj:SetActive(false)
end

function BagPanel:ToggleValueChange(type)
    if type==self.nowType then
        return
    end

    for i=1,#self.items do
        self.items[i]:Destroy()
    end

    self.items={}

    local nowItems=nil

    if type==1 then
        nowItems=PlayerData.equips
    elseif type==2 then
        nowItems=PlayerData.items
    else
        nowItems=PlayerData.gems
    end

    for i=1,#nowItems do
        local grid=ItemGrid:new()
        grid:Init(self.content)
        grid:InitData(nowItems[i])

        table.insert(self.items,grid)
    end
    self.nowType=type
end