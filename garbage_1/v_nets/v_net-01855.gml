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
  id 1855
  arrival_time 40879.045387667924
  lifetime 807.8216408801247
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 18
    gpu 23
    rom 49
  ]
  node [
    id 1
    label "1"
    cpu 16
    gpu 49
    rom 44
  ]
  node [
    id 2
    label "2"
    cpu 36
    gpu 15
    rom 34
  ]
  node [
    id 3
    label "3"
    cpu 4
    gpu 26
    rom 36
  ]
  node [
    id 4
    label "4"
    cpu 27
    gpu 20
    rom 8
  ]
  node [
    id 5
    label "5"
    cpu 3
    gpu 45
    rom 34
  ]
  node [
    id 6
    label "6"
    cpu 8
    gpu 4
    rom 13
  ]
  node [
    id 7
    label "7"
    cpu 14
    gpu 27
    rom 41
  ]
  node [
    id 8
    label "8"
    cpu 21
    gpu 43
    rom 42
  ]
  node [
    id 9
    label "9"
    cpu 24
    gpu 45
    rom 39
  ]
  edge [
    source 0
    target 1
    bw 50
  ]
  edge [
    source 1
    target 2
    bw 27
  ]
  edge [
    source 2
    target 3
    bw 48
  ]
  edge [
    source 3
    target 4
    bw 38
  ]
  edge [
    source 4
    target 5
    bw 3
  ]
  edge [
    source 5
    target 6
    bw 46
  ]
  edge [
    source 6
    target 7
    bw 46
  ]
  edge [
    source 7
    target 8
    bw 28
  ]
  edge [
    source 8
    target 9
    bw 10
  ]
]
