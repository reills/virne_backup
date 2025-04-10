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
  id 1862
  arrival_time 40935.472101590596
  lifetime 1079.4495113488097
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 20
    gpu 0
    rom 21
  ]
  node [
    id 1
    label "1"
    cpu 50
    gpu 42
    rom 16
  ]
  node [
    id 2
    label "2"
    cpu 17
    gpu 41
    rom 37
  ]
  node [
    id 3
    label "3"
    cpu 25
    gpu 43
    rom 21
  ]
  node [
    id 4
    label "4"
    cpu 23
    gpu 17
    rom 12
  ]
  node [
    id 5
    label "5"
    cpu 32
    gpu 6
    rom 11
  ]
  node [
    id 6
    label "6"
    cpu 30
    gpu 5
    rom 18
  ]
  node [
    id 7
    label "7"
    cpu 20
    gpu 48
    rom 45
  ]
  node [
    id 8
    label "8"
    cpu 26
    gpu 32
    rom 28
  ]
  node [
    id 9
    label "9"
    cpu 31
    gpu 29
    rom 14
  ]
  node [
    id 10
    label "10"
    cpu 20
    gpu 13
    rom 1
  ]
  node [
    id 11
    label "11"
    cpu 3
    gpu 12
    rom 23
  ]
  edge [
    source 0
    target 1
    bw 36
  ]
  edge [
    source 1
    target 2
    bw 11
  ]
  edge [
    source 2
    target 3
    bw 16
  ]
  edge [
    source 3
    target 4
    bw 21
  ]
  edge [
    source 4
    target 5
    bw 32
  ]
  edge [
    source 5
    target 6
    bw 16
  ]
  edge [
    source 6
    target 7
    bw 14
  ]
  edge [
    source 7
    target 8
    bw 30
  ]
  edge [
    source 8
    target 9
    bw 36
  ]
  edge [
    source 9
    target 10
    bw 49
  ]
  edge [
    source 10
    target 11
    bw 32
  ]
]
