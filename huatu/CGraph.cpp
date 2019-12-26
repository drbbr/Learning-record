#include "stdafx.h"
#include "CGraph.h"

IMPLEMENT_SERIAL(CGraph,CObject,1)
CGraph::CGraph()
{
}


CGraph::~CGraph()
{
}



CGraph::CGraph(int m_DrawType, CPoint m_begin, CPoint m_end)
{
	m_ptOrigin = m_begin;
	m_nType = m_DrawType;
	m_ptEnd = m_end;
	switch (m_DrawType) 
	{
	case 1:
	{
		m_nAre = 3.14*abs(m_ptOrigin.x - m_ptEnd.x)*abs(m_ptOrigin.y - m_ptEnd.y);
		if (abs(m_ptOrigin.x - m_ptEnd.x) > abs(m_ptOrigin.y - m_ptEnd.y))
		{
			m_nPer = 2*3.14*abs(m_ptOrigin.y - m_ptEnd.y)+4*(abs(m_ptOrigin.x - m_ptEnd.x) -abs(m_ptOrigin.y - m_ptEnd.y));
		}
		else 
			m_nPer = 2 * 3.14*abs(m_ptOrigin.x - m_ptEnd.x) + 4 *( abs(m_ptOrigin.y - m_ptEnd.y) - abs(m_ptOrigin.x - m_ptEnd.x));
		break;
	}
	case 2:
	{
		m_nAre = abs((m_ptOrigin.x - m_ptEnd.x)*(m_ptOrigin.y - m_ptEnd.y));
		m_nPer = (abs(m_ptOrigin.x - m_ptEnd.x) + abs(m_ptOrigin.y - m_ptEnd.y)) * 2;
		break;
	}
	case 3:
	{
		m_nAre = abs(m_ptOrigin.x - m_ptEnd.x)*abs(m_ptOrigin.y - m_ptEnd.y) / 2;
		m_nPer = abs(m_ptOrigin.x - m_ptEnd.x) + abs(m_ptOrigin.y - m_ptEnd.y) + sqrt((m_ptOrigin.x - m_ptEnd.x)*(m_ptOrigin.x - m_ptEnd.x) + (m_ptOrigin.y - m_ptEnd.y)*(m_ptOrigin.y - m_ptEnd.y));
		break;
	}
	case 4:
	{
		m_nAre = abs(m_ptOrigin.x - m_ptEnd.x) / 2 * abs(m_ptOrigin.y - m_ptEnd.y);
		m_nPer = abs(m_ptOrigin.x - m_ptEnd.x)+ 2*(sqrt(abs(m_ptOrigin.x - m_ptEnd.x)/2* m_ptOrigin.x - m_ptEnd.x) / 2+ abs(m_ptOrigin.y - m_ptEnd.y)* abs(m_ptOrigin.y - m_ptEnd.y));
		break;
	}
	default:
		break;
	}
}
void CGraph::Draw(CDC *pDC)
{
	CBrush *pbrush = CBrush::FromHandle((HBRUSH)GetStockObject(NULL_BRUSH)); //创建绘制时填充的画刷(使透明）
	pDC->SelectObject(pbrush);
	CRect rect(m_ptOrigin, m_ptEnd);
	switch (m_nType) //根据绘制种类进行绘制
	{
	case 1:
		pDC->Ellipse(rect);
		break;
	case 2:
		pDC->Rectangle(rect);
		break;
	case 3:
	{
		POINT p[3];
		p[0] = rect.TopLeft();
		p[1] = rect.BottomRight();
		p[2].y = p[1].y;
		p[2].x = p[1].x - rect.Width() ;
		pDC->Polygon(p, 3); //三角形
		break;
	}
	case 4:
	{
		POINT p[4];
		p[0] = rect.TopLeft();
		p[1].x = p[0].x + rect.Width() ;
		p[1].y = p[0].y;
		p[2].x = p[0].x;
		p[2].y = p[0].y+rect.Height();
		p[3].x = p[2].x - rect.Width() ;
		p[3].y = p[2].y;
		pDC->Polygon(p, 4);		//平行四边形
	}
	default:
		break;
	}

}

void CGraph::Serialize(CArchive& ar)
{
	if (ar.IsStoring())
		ar << m_nType << m_ptOrigin << m_ptEnd;
	else
		ar >> m_nType >> m_ptOrigin >> m_ptEnd;
}
