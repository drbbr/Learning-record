#pragma once
class CGraph :public CObject 
{
public:
	CPoint m_ptOrigin;
	CPoint m_ptEnd;
	int m_nType;
	double m_nAre;
	double m_nPer;
	CGraph();
	~CGraph();
	void Serialize(CArchive& ar);
	DECLARE_SERIAL(CGraph)
	CGraph(int m_DrawType, CPoint m_begin, CPoint m_end);
	void Draw(CDC *pDc);
};
