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
  id 1804
  arrival_time 40067.525968298454
  lifetime 2562.846473550312
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 46
    gpu 38
    rom 49
  ]
  node [
    id 1
    label "1"
    cpu 50
    gpu 17
    rom 8
  ]
  node [
    id 2
    label "2"
    cpu 46
    gpu 4
    rom 37
  ]
  node [
    id 3
    label "3"
    cpu 47
    gpu 28
    rom 5
  ]
  node [
    id 4
    label "4"
    cpu 17
    gpu 3
    rom 27
  ]
  node [
    id 5
    label "5"
    cpu 20
    gpu 42
    rom 29
  ]
  node [
    id 6
    label "6"
    cpu 50
    gpu 32
    rom 33
  ]
  node [
    id 7
    label "7"
    cpu 3
    gpu 10
    rom 7
  ]
  node [
    id 8
    label "8"
    cpu 24
    gpu 18
    rom 22
  ]
  edge [
    source 0
    target 1
    bw 25
  ]
  edge [
    source 1
    target 2
    bw 47
  ]
  edge [
    source 2
    target 3
    bw 13
  ]
  edge [
    source 3
    target 4
    bw 8
  ]
  edge [
    source 4
    target 5
    bw 9
  ]
  edge [
    source 5
    target 6
    bw 0
  ]
  edge [
    source 6
    target 7
    bw 49
  ]
  edge [
    source 7
    target 8
    bw 10
  ]
]
