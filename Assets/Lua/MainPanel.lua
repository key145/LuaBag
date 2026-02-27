MainPanel={}

MainPanel.panelObj=nil
MainPanel.bagBtn=nil
MainPanel.skillBtn=nil

function MainPanel:Init()
    if self.panelObj==nil then
        self.panelObj = ABMgr:LoadRes("ui", "MainPanel", typeof(GameObject))
        self.panelObj.transform:SetParent(Canvas,false)
        self.bagBtn=self.panelObj.transform:Find("BagBtn"):GetComponent(typeof(Button))
        self.skillBtn=self.panelObj.transform:Find("SkillBtn"):GetComponent(typeof(Button))
        self.bagBtn.onClick:AddListener(function()
            self:BagBtnClick()
        end)
    end
end

function MainPanel:ShowPanel()
    MainPanel:Init()
    self.panelObj:SetActive(true)
end

function MainPanel:HidePanel()
    self.panelObj:SetActive(true)
end

function MainPanel:BagBtnClick()
    BagPanel:ShowPanel()
end