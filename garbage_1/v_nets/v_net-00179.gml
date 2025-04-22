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
  id 179
  arrival_time 3318.011135181477
  lifetime 1064.5556689501157
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 20
    gpu 48
    rom 39
  ]
  node [
    id 1
    label "1"
    cpu 3
    gpu 39
    rom 47
  ]
  node [
    id 2
    label "2"
    cpu 22
    gpu 14
    rom 13
  ]
  node [
    id 3
    label "3"
    cpu 35
    gpu 38
    rom 6
  ]
  node [
    id 4
    label "4"
    cpu 41
    gpu 11
    rom 42
  ]
  node [
    id 5
    label "5"
    cpu 21
    gpu 0
    rom 36
  ]
  node [
    id 6
    label "6"
    cpu 21
    gpu 10
    rom 3
  ]
  node [
    id 7
    label "7"
    cpu 43
    gpu 24
    rom 19
  ]
  node [
    id 8
    label "8"
    cpu 29
    gpu 2
    rom 41
  ]
  node [
    id 9
    label "9"
    cpu 25
    gpu 2
    rom 2
  ]
  node [
    id 10
    label "10"
    cpu 33
    gpu 27
    rom 15
  ]
  edge [
    source 0
    target 1
    bw 14
  ]
  edge [
    source 1
    target 2
    bw 6
  ]
  edge [
    source 2
    target 3
    bw 31
  ]
  edge [
    source 3
    target 4
    bw 32
  ]
  edge [
    source 4
    target 5
    bw 40
  ]
  edge [
    source 5
    target 6
    bw 35
  ]
  edge [
    source 6
    target 7
    bw 3
  ]
  edge [
    source 7
    target 8
    bw 18
  ]
  edge [
    source 8
    target 9
    bw 23
  ]
  edge [
    source 9
    target 10
    bw 33
  ]
]
