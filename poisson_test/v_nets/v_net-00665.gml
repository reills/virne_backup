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
  id 665
  arrival_time 14181.146116434864
  lifetime 245.94887194581537
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 15
    gpu 24
    rom 10
  ]
  node [
    id 1
    label "1"
    cpu 34
    gpu 8
    rom 5
  ]
  node [
    id 2
    label "2"
    cpu 29
    gpu 20
    rom 4
  ]
  node [
    id 3
    label "3"
    cpu 46
    gpu 44
    rom 39
  ]
  node [
    id 4
    label "4"
    cpu 43
    gpu 32
    rom 35
  ]
  node [
    id 5
    label "5"
    cpu 37
    gpu 34
    rom 42
  ]
  node [
    id 6
    label "6"
    cpu 26
    gpu 28
    rom 45
  ]
  node [
    id 7
    label "7"
    cpu 43
    gpu 41
    rom 19
  ]
  node [
    id 8
    label "8"
    cpu 14
    gpu 8
    rom 12
  ]
  edge [
    source 0
    target 1
    bw 8
  ]
  edge [
    source 1
    target 2
    bw 28
  ]
  edge [
    source 2
    target 3
    bw 19
  ]
  edge [
    source 3
    target 4
    bw 15
  ]
  edge [
    source 4
    target 5
    bw 50
  ]
  edge [
    source 5
    target 6
    bw 37
  ]
  edge [
    source 6
    target 7
    bw 34
  ]
  edge [
    source 7
    target 8
    bw 47
  ]
]
