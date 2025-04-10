graph [
  node_attrs_setting [
    name "cpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "gpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "rom"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  link_attrs_setting "_networkx_list_start"
  link_attrs_setting [
    name "bw"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "link"
    type "resource"
  ]
  id 467
  arrival_time 8804.910447500986
  lifetime 198.25351038912885
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 48
    gpu 10
    rom 12
  ]
  node [
    id 1
    label "1"
    cpu 42
    gpu 26
    rom 21
  ]
  node [
    id 2
    label "2"
    cpu 2
    gpu 40
    rom 19
  ]
  node [
    id 3
    label "3"
    cpu 29
    gpu 30
    rom 37
  ]
  node [
    id 4
    label "4"
    cpu 38
    gpu 20
    rom 21
  ]
  node [
    id 5
    label "5"
    cpu 15
    gpu 17
    rom 29
  ]
  node [
    id 6
    label "6"
    cpu 26
    gpu 7
    rom 14
  ]
  node [
    id 7
    label "7"
    cpu 25
    gpu 41
    rom 3
  ]
  node [
    id 8
    label "8"
    cpu 40
    gpu 33
    rom 10
  ]
  edge [
    source 0
    target 1
    bw 29
  ]
  edge [
    source 1
    target 2
    bw 3
  ]
  edge [
    source 2
    target 3
    bw 50
  ]
  edge [
    source 3
    target 4
    bw 7
  ]
  edge [
    source 4
    target 5
    bw 38
  ]
  edge [
    source 5
    target 6
    bw 1
  ]
  edge [
    source 6
    target 7
    bw 41
  ]
  edge [
    source 7
    target 8
    bw 32
  ]
]
