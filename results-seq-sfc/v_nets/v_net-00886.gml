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
  id 886
  arrival_time 18734.474871757462
  lifetime 863.0484263665434
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 25
    gpu 20
    rom 13
  ]
  node [
    id 1
    label "1"
    cpu 0
    gpu 15
    rom 6
  ]
  node [
    id 2
    label "2"
    cpu 15
    gpu 15
    rom 8
  ]
  node [
    id 3
    label "3"
    cpu 10
    gpu 31
    rom 4
  ]
  node [
    id 4
    label "4"
    cpu 39
    gpu 0
    rom 45
  ]
  node [
    id 5
    label "5"
    cpu 20
    gpu 20
    rom 13
  ]
  node [
    id 6
    label "6"
    cpu 11
    gpu 9
    rom 11
  ]
  node [
    id 7
    label "7"
    cpu 28
    gpu 33
    rom 48
  ]
  edge [
    source 0
    target 1
    bw 4
  ]
  edge [
    source 1
    target 2
    bw 34
  ]
  edge [
    source 2
    target 3
    bw 26
  ]
  edge [
    source 3
    target 4
    bw 49
  ]
  edge [
    source 4
    target 5
    bw 5
  ]
  edge [
    source 5
    target 6
    bw 3
  ]
  edge [
    source 6
    target 7
    bw 37
  ]
]
