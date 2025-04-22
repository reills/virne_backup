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
  id 199
  arrival_time 3559.2031224766492
  lifetime 3232.5143396078533
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 48
    gpu 5
    rom 8
  ]
  node [
    id 1
    label "1"
    cpu 19
    gpu 44
    rom 27
  ]
  node [
    id 2
    label "2"
    cpu 38
    gpu 25
    rom 11
  ]
  node [
    id 3
    label "3"
    cpu 44
    gpu 42
    rom 40
  ]
  node [
    id 4
    label "4"
    cpu 16
    gpu 3
    rom 5
  ]
  node [
    id 5
    label "5"
    cpu 44
    gpu 44
    rom 15
  ]
  node [
    id 6
    label "6"
    cpu 2
    gpu 31
    rom 35
  ]
  node [
    id 7
    label "7"
    cpu 31
    gpu 11
    rom 28
  ]
  node [
    id 8
    label "8"
    cpu 32
    gpu 24
    rom 33
  ]
  edge [
    source 0
    target 1
    bw 24
  ]
  edge [
    source 1
    target 2
    bw 41
  ]
  edge [
    source 2
    target 3
    bw 44
  ]
  edge [
    source 3
    target 4
    bw 21
  ]
  edge [
    source 4
    target 5
    bw 30
  ]
  edge [
    source 5
    target 6
    bw 32
  ]
  edge [
    source 6
    target 7
    bw 21
  ]
  edge [
    source 7
    target 8
    bw 1
  ]
]
