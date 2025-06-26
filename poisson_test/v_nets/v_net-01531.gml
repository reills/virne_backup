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
  id 1531
  arrival_time 33852.02252418003
  lifetime 1058.8526987025177
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 9
    gpu 48
    rom 14
  ]
  node [
    id 1
    label "1"
    cpu 31
    gpu 10
    rom 7
  ]
  node [
    id 2
    label "2"
    cpu 14
    gpu 15
    rom 42
  ]
  node [
    id 3
    label "3"
    cpu 4
    gpu 29
    rom 8
  ]
  node [
    id 4
    label "4"
    cpu 33
    gpu 31
    rom 5
  ]
  node [
    id 5
    label "5"
    cpu 21
    gpu 25
    rom 16
  ]
  node [
    id 6
    label "6"
    cpu 7
    gpu 46
    rom 37
  ]
  node [
    id 7
    label "7"
    cpu 33
    gpu 31
    rom 3
  ]
  node [
    id 8
    label "8"
    cpu 17
    gpu 46
    rom 39
  ]
  node [
    id 9
    label "9"
    cpu 4
    gpu 40
    rom 21
  ]
  node [
    id 10
    label "10"
    cpu 48
    gpu 16
    rom 36
  ]
  node [
    id 11
    label "11"
    cpu 47
    gpu 4
    rom 43
  ]
  node [
    id 12
    label "12"
    cpu 12
    gpu 5
    rom 2
  ]
  edge [
    source 0
    target 1
    bw 10
  ]
  edge [
    source 1
    target 2
    bw 19
  ]
  edge [
    source 2
    target 3
    bw 41
  ]
  edge [
    source 3
    target 4
    bw 5
  ]
  edge [
    source 4
    target 5
    bw 2
  ]
  edge [
    source 5
    target 6
    bw 36
  ]
  edge [
    source 6
    target 7
    bw 12
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
    bw 14
  ]
  edge [
    source 10
    target 11
    bw 39
  ]
  edge [
    source 11
    target 12
    bw 27
  ]
]
