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
  id 294
  arrival_time 5686.5445075718435
  lifetime 1261.8412099677655
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 13
    gpu 31
    rom 35
  ]
  node [
    id 1
    label "1"
    cpu 25
    gpu 30
    rom 29
  ]
  node [
    id 2
    label "2"
    cpu 24
    gpu 13
    rom 41
  ]
  node [
    id 3
    label "3"
    cpu 5
    gpu 27
    rom 10
  ]
  node [
    id 4
    label "4"
    cpu 41
    gpu 18
    rom 32
  ]
  node [
    id 5
    label "5"
    cpu 32
    gpu 31
    rom 12
  ]
  node [
    id 6
    label "6"
    cpu 40
    gpu 43
    rom 35
  ]
  node [
    id 7
    label "7"
    cpu 16
    gpu 34
    rom 18
  ]
  node [
    id 8
    label "8"
    cpu 13
    gpu 48
    rom 46
  ]
  edge [
    source 0
    target 1
    bw 38
  ]
  edge [
    source 1
    target 2
    bw 50
  ]
  edge [
    source 2
    target 3
    bw 41
  ]
  edge [
    source 3
    target 4
    bw 12
  ]
  edge [
    source 4
    target 5
    bw 35
  ]
  edge [
    source 5
    target 6
    bw 34
  ]
  edge [
    source 6
    target 7
    bw 49
  ]
  edge [
    source 7
    target 8
    bw 1
  ]
]
