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
  id 1398
  arrival_time 29390.508927642215
  lifetime 34.864159512198235
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 18
    gpu 49
    rom 20
  ]
  node [
    id 1
    label "1"
    cpu 27
    gpu 39
    rom 43
  ]
  node [
    id 2
    label "2"
    cpu 2
    gpu 7
    rom 24
  ]
  node [
    id 3
    label "3"
    cpu 14
    gpu 39
    rom 18
  ]
  node [
    id 4
    label "4"
    cpu 16
    gpu 29
    rom 22
  ]
  node [
    id 5
    label "5"
    cpu 38
    gpu 25
    rom 14
  ]
  node [
    id 6
    label "6"
    cpu 7
    gpu 0
    rom 19
  ]
  node [
    id 7
    label "7"
    cpu 17
    gpu 19
    rom 24
  ]
  node [
    id 8
    label "8"
    cpu 4
    gpu 50
    rom 13
  ]
  node [
    id 9
    label "9"
    cpu 5
    gpu 32
    rom 33
  ]
  node [
    id 10
    label "10"
    cpu 21
    gpu 12
    rom 30
  ]
  edge [
    source 0
    target 1
    bw 50
  ]
  edge [
    source 1
    target 2
    bw 4
  ]
  edge [
    source 2
    target 3
    bw 11
  ]
  edge [
    source 3
    target 4
    bw 47
  ]
  edge [
    source 4
    target 5
    bw 24
  ]
  edge [
    source 5
    target 6
    bw 37
  ]
  edge [
    source 6
    target 7
    bw 29
  ]
  edge [
    source 7
    target 8
    bw 18
  ]
  edge [
    source 8
    target 9
    bw 22
  ]
  edge [
    source 9
    target 10
    bw 35
  ]
]
