package core

import (
	"fmt"
)

// Entity a gameobject, something in the system
type Entity struct {
	ID         string
	Name       string
	Transform  *Transform
	children   []*Entity
	components []Componenter
	EntityHolder
	ComponentHolder
	Initializer
}

// Add add a sub entity to this entity
func (ge *Entity) Add(e *Entity) {
	ge.children = append(ge.children, e)
}

func (ge *Entity) Remove(e *Entity) {
	panic("Not implemented")
}

// Attach add a component to this entity
func (ge *Entity) Attach(cmp Componenter) {
	cmp.SetParent(ge)
	// fmt.Printf("-- %v\n", cmp.GetParent())
	ge.components = append(ge.components, cmp)
}

func (ge *Entity) Detach(cmp Componenter) {
	panic("Not implemented")
}

// GetComponent get component by name
func (ge *Entity) GetComponent(t string) Componenter {
	tt := ""
	for q := 0; q < len(ge.components); q++ {
		tt = fmt.Sprintf("%T", ge.components[q])
		switch tt {
		case t:
			// fmt.Printf("%v\n", t)
			return ge.components[q]
			// default:
			// fmt.Printf("Asked for: %v got %v\n", t, tt)
		}
		// fmt.Printf("%v \n", reflect.TypeOf(ge.components[q]) == reflect.TypeOf(t))
	}
	return nil
}
