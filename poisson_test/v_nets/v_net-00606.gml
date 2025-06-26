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
  id 606
  arrival_time 12572.61259104485
  lifetime 3883.0129924440794
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 39
    gpu 35
    rom 29
  ]
  node [
    id 1
    label "1"
    cpu 13
    gpu 22
    rom 38
  ]
  node [
    id 2
    label "2"
    cpu 21
    gpu 30
    rom 27
  ]
  node [
    id 3
    label "3"
    cpu 44
    gpu 19
    rom 33
  ]
  node [
    id 4
    label "4"
    cpu 41
    gpu 10
    rom 20
  ]
  node [
    id 5
    label "5"
    cpu 44
    gpu 24
    rom 44
  ]
  node [
    id 6
    label "6"
    cpu 36
    gpu 38
    rom 0
  ]
  edge [
    source 0
    target 1
    bw 44
  ]
  edge [
    source 1
    target 2
    bw 1
  ]
  edge [
    source 2
    target 3
    bw 16
  ]
  edge [
    source 3
    target 4
    bw 9
  ]
  edge [
    source 4
    target 5
    bw 32
  ]
  edge [
    source 5
    target 6
    bw 32
  ]
]
