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
  id 926
  arrival_time 19897.200613883146
  lifetime 702.2379810670612
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 41
    gpu 1
    rom 20
  ]
  node [
    id 1
    label "1"
    cpu 10
    gpu 26
    rom 17
  ]
  node [
    id 2
    label "2"
    cpu 42
    gpu 32
    rom 38
  ]
  node [
    id 3
    label "3"
    cpu 9
    gpu 7
    rom 41
  ]
  node [
    id 4
    label "4"
    cpu 9
    gpu 35
    rom 6
  ]
  node [
    id 5
    label "5"
    cpu 24
    gpu 11
    rom 16
  ]
  node [
    id 6
    label "6"
    cpu 21
    gpu 13
    rom 33
  ]
  node [
    id 7
    label "7"
    cpu 23
    gpu 1
    rom 46
  ]
  node [
    id 8
    label "8"
    cpu 24
    gpu 20
    rom 5
  ]
  node [
    id 9
    label "9"
    cpu 41
    gpu 28
    rom 8
  ]
  node [
    id 10
    label "10"
    cpu 48
    gpu 13
    rom 30
  ]
  node [
    id 11
    label "11"
    cpu 31
    gpu 16
    rom 47
  ]
  node [
    id 12
    label "12"
    cpu 19
    gpu 27
    rom 36
  ]
  node [
    id 13
    label "13"
    cpu 31
    gpu 15
    rom 45
  ]
  edge [
    source 0
    target 1
    bw 43
  ]
  edge [
    source 1
    target 2
    bw 15
  ]
  edge [
    source 2
    target 3
    bw 6
  ]
  edge [
    source 3
    target 4
    bw 20
  ]
  edge [
    source 4
    target 5
    bw 2
  ]
  edge [
    source 5
    target 6
    bw 45
  ]
  edge [
    source 6
    target 7
    bw 6
  ]
  edge [
    source 7
    target 8
    bw 1
  ]
  edge [
    source 8
    target 9
    bw 34
  ]
  edge [
    source 9
    target 10
    bw 30
  ]
  edge [
    source 10
    target 11
    bw 34
  ]
  edge [
    source 11
    target 12
    bw 49
  ]
  edge [
    source 12
    target 13
    bw 45
  ]
]
