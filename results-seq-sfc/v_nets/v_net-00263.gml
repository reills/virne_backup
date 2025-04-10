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
  id 263
  arrival_time 5120.8511700944155
  lifetime 706.6796749380455
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 28
    gpu 10
    rom 43
  ]
  node [
    id 1
    label "1"
    cpu 3
    gpu 32
    rom 1
  ]
  node [
    id 2
    label "2"
    cpu 11
    gpu 3
    rom 21
  ]
  node [
    id 3
    label "3"
    cpu 30
    gpu 27
    rom 0
  ]
  node [
    id 4
    label "4"
    cpu 14
    gpu 0
    rom 2
  ]
  node [
    id 5
    label "5"
    cpu 14
    gpu 36
    rom 37
  ]
  node [
    id 6
    label "6"
    cpu 41
    gpu 15
    rom 3
  ]
  node [
    id 7
    label "7"
    cpu 9
    gpu 25
    rom 13
  ]
  node [
    id 8
    label "8"
    cpu 0
    gpu 35
    rom 20
  ]
  node [
    id 9
    label "9"
    cpu 22
    gpu 50
    rom 24
  ]
  node [
    id 10
    label "10"
    cpu 40
    gpu 21
    rom 44
  ]
  edge [
    source 0
    target 1
    bw 17
  ]
  edge [
    source 1
    target 2
    bw 18
  ]
  edge [
    source 2
    target 3
    bw 47
  ]
  edge [
    source 3
    target 4
    bw 34
  ]
  edge [
    source 4
    target 5
    bw 8
  ]
  edge [
    source 5
    target 6
    bw 44
  ]
  edge [
    source 6
    target 7
    bw 39
  ]
  edge [
    source 7
    target 8
    bw 0
  ]
  edge [
    source 8
    target 9
    bw 19
  ]
  edge [
    source 9
    target 10
    bw 44
  ]
]
