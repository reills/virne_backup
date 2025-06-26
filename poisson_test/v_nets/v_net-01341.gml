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
  id 1341
  arrival_time 28404.79492079525
  lifetime 1134.077966859606
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 43
    gpu 41
    rom 26
  ]
  node [
    id 1
    label "1"
    cpu 29
    gpu 22
    rom 10
  ]
  node [
    id 2
    label "2"
    cpu 32
    gpu 20
    rom 4
  ]
  node [
    id 3
    label "3"
    cpu 7
    gpu 47
    rom 27
  ]
  node [
    id 4
    label "4"
    cpu 46
    gpu 21
    rom 12
  ]
  node [
    id 5
    label "5"
    cpu 14
    gpu 40
    rom 12
  ]
  node [
    id 6
    label "6"
    cpu 50
    gpu 34
    rom 24
  ]
  node [
    id 7
    label "7"
    cpu 6
    gpu 23
    rom 6
  ]
  node [
    id 8
    label "8"
    cpu 21
    gpu 40
    rom 48
  ]
  edge [
    source 0
    target 1
    bw 2
  ]
  edge [
    source 1
    target 2
    bw 18
  ]
  edge [
    source 2
    target 3
    bw 8
  ]
  edge [
    source 3
    target 4
    bw 17
  ]
  edge [
    source 4
    target 5
    bw 2
  ]
  edge [
    source 5
    target 6
    bw 43
  ]
  edge [
    source 6
    target 7
    bw 28
  ]
  edge [
    source 7
    target 8
    bw 18
  ]
]
