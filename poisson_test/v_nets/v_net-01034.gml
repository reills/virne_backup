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
  id 1034
  arrival_time 21895.70644784667
  lifetime 1176.513933325304
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 32
    gpu 21
    rom 20
  ]
  node [
    id 1
    label "1"
    cpu 22
    gpu 36
    rom 22
  ]
  node [
    id 2
    label "2"
    cpu 14
    gpu 20
    rom 30
  ]
  node [
    id 3
    label "3"
    cpu 44
    gpu 24
    rom 40
  ]
  node [
    id 4
    label "4"
    cpu 13
    gpu 45
    rom 15
  ]
  node [
    id 5
    label "5"
    cpu 20
    gpu 45
    rom 44
  ]
  node [
    id 6
    label "6"
    cpu 15
    gpu 3
    rom 5
  ]
  node [
    id 7
    label "7"
    cpu 21
    gpu 37
    rom 1
  ]
  node [
    id 8
    label "8"
    cpu 2
    gpu 43
    rom 41
  ]
  edge [
    source 0
    target 1
    bw 31
  ]
  edge [
    source 1
    target 2
    bw 12
  ]
  edge [
    source 2
    target 3
    bw 15
  ]
  edge [
    source 3
    target 4
    bw 13
  ]
  edge [
    source 4
    target 5
    bw 9
  ]
  edge [
    source 5
    target 6
    bw 49
  ]
  edge [
    source 6
    target 7
    bw 46
  ]
  edge [
    source 7
    target 8
    bw 36
  ]
]
