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
  id 1348
  arrival_time 28582.57268998973
  lifetime 2691.9698230006084
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 47
    gpu 44
    rom 43
  ]
  node [
    id 1
    label "1"
    cpu 35
    gpu 29
    rom 4
  ]
  node [
    id 2
    label "2"
    cpu 6
    gpu 11
    rom 9
  ]
  node [
    id 3
    label "3"
    cpu 22
    gpu 32
    rom 19
  ]
  node [
    id 4
    label "4"
    cpu 40
    gpu 19
    rom 34
  ]
  node [
    id 5
    label "5"
    cpu 50
    gpu 2
    rom 7
  ]
  node [
    id 6
    label "6"
    cpu 4
    gpu 25
    rom 20
  ]
  node [
    id 7
    label "7"
    cpu 46
    gpu 2
    rom 7
  ]
  node [
    id 8
    label "8"
    cpu 45
    gpu 20
    rom 5
  ]
  node [
    id 9
    label "9"
    cpu 48
    gpu 12
    rom 29
  ]
  edge [
    source 0
    target 1
    bw 5
  ]
  edge [
    source 1
    target 2
    bw 37
  ]
  edge [
    source 2
    target 3
    bw 20
  ]
  edge [
    source 3
    target 4
    bw 26
  ]
  edge [
    source 4
    target 5
    bw 26
  ]
  edge [
    source 5
    target 6
    bw 40
  ]
  edge [
    source 6
    target 7
    bw 39
  ]
  edge [
    source 7
    target 8
    bw 16
  ]
  edge [
    source 8
    target 9
    bw 23
  ]
]
