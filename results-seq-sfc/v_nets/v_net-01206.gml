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
  id 1206
  arrival_time 25116.40603115414
  lifetime 2218.1303406470424
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 24
    gpu 45
    rom 4
  ]
  node [
    id 1
    label "1"
    cpu 41
    gpu 1
    rom 9
  ]
  node [
    id 2
    label "2"
    cpu 48
    gpu 27
    rom 1
  ]
  node [
    id 3
    label "3"
    cpu 0
    gpu 16
    rom 18
  ]
  node [
    id 4
    label "4"
    cpu 21
    gpu 50
    rom 38
  ]
  node [
    id 5
    label "5"
    cpu 30
    gpu 20
    rom 35
  ]
  node [
    id 6
    label "6"
    cpu 41
    gpu 2
    rom 10
  ]
  node [
    id 7
    label "7"
    cpu 11
    gpu 46
    rom 44
  ]
  node [
    id 8
    label "8"
    cpu 49
    gpu 30
    rom 21
  ]
  node [
    id 9
    label "9"
    cpu 4
    gpu 32
    rom 2
  ]
  node [
    id 10
    label "10"
    cpu 7
    gpu 22
    rom 44
  ]
  node [
    id 11
    label "11"
    cpu 17
    gpu 28
    rom 8
  ]
  node [
    id 12
    label "12"
    cpu 18
    gpu 5
    rom 6
  ]
  node [
    id 13
    label "13"
    cpu 38
    gpu 9
    rom 19
  ]
  node [
    id 14
    label "14"
    cpu 14
    gpu 41
    rom 40
  ]
  edge [
    source 0
    target 1
    bw 40
  ]
  edge [
    source 1
    target 2
    bw 24
  ]
  edge [
    source 2
    target 3
    bw 42
  ]
  edge [
    source 3
    target 4
    bw 1
  ]
  edge [
    source 4
    target 5
    bw 38
  ]
  edge [
    source 5
    target 6
    bw 35
  ]
  edge [
    source 6
    target 7
    bw 18
  ]
  edge [
    source 7
    target 8
    bw 3
  ]
  edge [
    source 8
    target 9
    bw 4
  ]
  edge [
    source 9
    target 10
    bw 47
  ]
  edge [
    source 10
    target 11
    bw 33
  ]
  edge [
    source 11
    target 12
    bw 45
  ]
  edge [
    source 12
    target 13
    bw 45
  ]
  edge [
    source 13
    target 14
    bw 29
  ]
]
