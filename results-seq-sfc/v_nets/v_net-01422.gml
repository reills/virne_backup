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
  id 1422
  arrival_time 29701.390890610226
  lifetime 674.4479187364418
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 22
    gpu 28
    rom 11
  ]
  node [
    id 1
    label "1"
    cpu 27
    gpu 35
    rom 20
  ]
  node [
    id 2
    label "2"
    cpu 18
    gpu 49
    rom 14
  ]
  node [
    id 3
    label "3"
    cpu 6
    gpu 28
    rom 3
  ]
  node [
    id 4
    label "4"
    cpu 41
    gpu 41
    rom 30
  ]
  node [
    id 5
    label "5"
    cpu 19
    gpu 35
    rom 47
  ]
  node [
    id 6
    label "6"
    cpu 31
    gpu 48
    rom 6
  ]
  node [
    id 7
    label "7"
    cpu 35
    gpu 19
    rom 16
  ]
  node [
    id 8
    label "8"
    cpu 49
    gpu 4
    rom 26
  ]
  node [
    id 9
    label "9"
    cpu 47
    gpu 20
    rom 40
  ]
  node [
    id 10
    label "10"
    cpu 32
    gpu 29
    rom 35
  ]
  edge [
    source 0
    target 1
    bw 37
  ]
  edge [
    source 1
    target 2
    bw 0
  ]
  edge [
    source 2
    target 3
    bw 40
  ]
  edge [
    source 3
    target 4
    bw 12
  ]
  edge [
    source 4
    target 5
    bw 39
  ]
  edge [
    source 5
    target 6
    bw 39
  ]
  edge [
    source 6
    target 7
    bw 29
  ]
  edge [
    source 7
    target 8
    bw 39
  ]
  edge [
    source 8
    target 9
    bw 24
  ]
  edge [
    source 9
    target 10
    bw 18
  ]
]
