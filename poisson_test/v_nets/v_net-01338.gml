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
  id 1338
  arrival_time 28379.913536414046
  lifetime 360.0934736932728
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 8
    gpu 34
    rom 9
  ]
  node [
    id 1
    label "1"
    cpu 40
    gpu 42
    rom 25
  ]
  node [
    id 2
    label "2"
    cpu 25
    gpu 46
    rom 28
  ]
  node [
    id 3
    label "3"
    cpu 23
    gpu 47
    rom 23
  ]
  node [
    id 4
    label "4"
    cpu 22
    gpu 39
    rom 30
  ]
  node [
    id 5
    label "5"
    cpu 26
    gpu 18
    rom 25
  ]
  node [
    id 6
    label "6"
    cpu 11
    gpu 26
    rom 17
  ]
  node [
    id 7
    label "7"
    cpu 27
    gpu 49
    rom 24
  ]
  node [
    id 8
    label "8"
    cpu 6
    gpu 29
    rom 11
  ]
  node [
    id 9
    label "9"
    cpu 34
    gpu 45
    rom 3
  ]
  edge [
    source 0
    target 1
    bw 7
  ]
  edge [
    source 1
    target 2
    bw 15
  ]
  edge [
    source 2
    target 3
    bw 5
  ]
  edge [
    source 3
    target 4
    bw 44
  ]
  edge [
    source 4
    target 5
    bw 45
  ]
  edge [
    source 5
    target 6
    bw 26
  ]
  edge [
    source 6
    target 7
    bw 19
  ]
  edge [
    source 7
    target 8
    bw 33
  ]
  edge [
    source 8
    target 9
    bw 31
  ]
]
