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
  id 774
  arrival_time 16160.818618081572
  lifetime 247.6376621209881
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 0
    gpu 26
    rom 49
  ]
  node [
    id 1
    label "1"
    cpu 37
    gpu 28
    rom 37
  ]
  node [
    id 2
    label "2"
    cpu 45
    gpu 32
    rom 27
  ]
  node [
    id 3
    label "3"
    cpu 10
    gpu 24
    rom 22
  ]
  node [
    id 4
    label "4"
    cpu 2
    gpu 38
    rom 44
  ]
  node [
    id 5
    label "5"
    cpu 3
    gpu 1
    rom 23
  ]
  node [
    id 6
    label "6"
    cpu 32
    gpu 47
    rom 26
  ]
  node [
    id 7
    label "7"
    cpu 0
    gpu 14
    rom 16
  ]
  node [
    id 8
    label "8"
    cpu 20
    gpu 13
    rom 11
  ]
  node [
    id 9
    label "9"
    cpu 14
    gpu 33
    rom 15
  ]
  node [
    id 10
    label "10"
    cpu 41
    gpu 42
    rom 18
  ]
  node [
    id 11
    label "11"
    cpu 34
    gpu 24
    rom 25
  ]
  node [
    id 12
    label "12"
    cpu 0
    gpu 44
    rom 32
  ]
  edge [
    source 0
    target 1
    bw 44
  ]
  edge [
    source 1
    target 2
    bw 18
  ]
  edge [
    source 2
    target 3
    bw 35
  ]
  edge [
    source 3
    target 4
    bw 2
  ]
  edge [
    source 4
    target 5
    bw 1
  ]
  edge [
    source 5
    target 6
    bw 7
  ]
  edge [
    source 6
    target 7
    bw 5
  ]
  edge [
    source 7
    target 8
    bw 47
  ]
  edge [
    source 8
    target 9
    bw 21
  ]
  edge [
    source 9
    target 10
    bw 3
  ]
  edge [
    source 10
    target 11
    bw 12
  ]
  edge [
    source 11
    target 12
    bw 17
  ]
]
