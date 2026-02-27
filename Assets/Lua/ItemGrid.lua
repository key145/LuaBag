Object:subClass("ItemGrid")

ItemGrid.obj=nil
ItemGrid.icon=nil
ItemGrid.numText=nil

function ItemGrid:Init(father)
    self.obj=ABMgr:LoadRes("ui","ItemGrid",typeof(GameObject))
    self.icon=self.obj.transform:Find("Icon"):GetComponent(typeof(Image))
    self.numText=self.obj.transform:Find("Count"):GetComponent(typeof(TextMeshProUGUI))

    self.obj.transform:SetParent(father,false)
end

function ItemGrid:InitData(data)
    local itemData=ItemData[data.id]
    local strs=string.split(itemData.icon,"_")
    local spriteAtlas=ABMgr:LoadRes("ui",strs[1],typeof(SpriteAtlas))
    self.icon.sprite=spriteAtlas:GetSprite(strs[2])

    self.numText.text=data.num
end

function ItemGrid:Destroy()
    GameObject.Destroy(self.obj)
    self.obj=nil
end
