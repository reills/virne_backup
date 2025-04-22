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
  id 1574
  arrival_time 35133.10871623085
  lifetime 581.6558607995221
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 45
    gpu 21
    rom 1
  ]
  node [
    id 1
    label "1"
    cpu 29
    gpu 10
    rom 35
  ]
  node [
    id 2
    label "2"
    cpu 29
    gpu 25
    rom 3
  ]
  node [
    id 3
    label "3"
    cpu 17
    gpu 12
    rom 43
  ]
  node [
    id 4
    label "4"
    cpu 32
    gpu 10
    rom 8
  ]
  node [
    id 5
    label "5"
    cpu 22
    gpu 47
    rom 43
  ]
  node [
    id 6
    label "6"
    cpu 32
    gpu 31
    rom 37
  ]
  node [
    id 7
    label "7"
    cpu 10
    gpu 37
    rom 36
  ]
  node [
    id 8
    label "8"
    cpu 29
    gpu 7
    rom 50
  ]
  node [
    id 9
    label "9"
    cpu 0
    gpu 17
    rom 36
  ]
  node [
    id 10
    label "10"
    cpu 41
    gpu 46
    rom 48
  ]
  edge [
    source 0
    target 1
    bw 45
  ]
  edge [
    source 1
    target 2
    bw 48
  ]
  edge [
    source 2
    target 3
    bw 6
  ]
  edge [
    source 3
    target 4
    bw 5
  ]
  edge [
    source 4
    target 5
    bw 2
  ]
  edge [
    source 5
    target 6
    bw 38
  ]
  edge [
    source 6
    target 7
    bw 46
  ]
  edge [
    source 7
    target 8
    bw 3
  ]
  edge [
    source 8
    target 9
    bw 46
  ]
  edge [
    source 9
    target 10
    bw 47
  ]
]
