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
  id 134
  arrival_time 2333.583860331886
  lifetime 490.5099707041354
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 37
    gpu 32
    rom 50
  ]
  node [
    id 1
    label "1"
    cpu 28
    gpu 47
    rom 43
  ]
  node [
    id 2
    label "2"
    cpu 14
    gpu 46
    rom 28
  ]
  node [
    id 3
    label "3"
    cpu 13
    gpu 33
    rom 35
  ]
  node [
    id 4
    label "4"
    cpu 27
    gpu 22
    rom 22
  ]
  node [
    id 5
    label "5"
    cpu 33
    gpu 49
    rom 37
  ]
  node [
    id 6
    label "6"
    cpu 42
    gpu 5
    rom 21
  ]
  node [
    id 7
    label "7"
    cpu 9
    gpu 33
    rom 23
  ]
  node [
    id 8
    label "8"
    cpu 44
    gpu 9
    rom 43
  ]
  node [
    id 9
    label "9"
    cpu 6
    gpu 48
    rom 2
  ]
  node [
    id 10
    label "10"
    cpu 28
    gpu 9
    rom 22
  ]
  edge [
    source 0
    target 1
    bw 20
  ]
  edge [
    source 1
    target 2
    bw 9
  ]
  edge [
    source 2
    target 3
    bw 16
  ]
  edge [
    source 3
    target 4
    bw 45
  ]
  edge [
    source 4
    target 5
    bw 44
  ]
  edge [
    source 5
    target 6
    bw 10
  ]
  edge [
    source 6
    target 7
    bw 18
  ]
  edge [
    source 7
    target 8
    bw 4
  ]
  edge [
    source 8
    target 9
    bw 11
  ]
  edge [
    source 9
    target 10
    bw 10
  ]
]
