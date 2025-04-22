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
  id 1496
  arrival_time 33267.00634027582
  lifetime 467.4800162965728
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 6
    gpu 46
    rom 17
  ]
  node [
    id 1
    label "1"
    cpu 26
    gpu 48
    rom 28
  ]
  node [
    id 2
    label "2"
    cpu 45
    gpu 49
    rom 29
  ]
  node [
    id 3
    label "3"
    cpu 13
    gpu 48
    rom 12
  ]
  node [
    id 4
    label "4"
    cpu 3
    gpu 5
    rom 13
  ]
  node [
    id 5
    label "5"
    cpu 35
    gpu 10
    rom 27
  ]
  node [
    id 6
    label "6"
    cpu 4
    gpu 3
    rom 3
  ]
  node [
    id 7
    label "7"
    cpu 27
    gpu 6
    rom 11
  ]
  node [
    id 8
    label "8"
    cpu 31
    gpu 2
    rom 21
  ]
  node [
    id 9
    label "9"
    cpu 16
    gpu 26
    rom 47
  ]
  node [
    id 10
    label "10"
    cpu 33
    gpu 15
    rom 32
  ]
  node [
    id 11
    label "11"
    cpu 49
    gpu 46
    rom 26
  ]
  node [
    id 12
    label "12"
    cpu 39
    gpu 2
    rom 18
  ]
  node [
    id 13
    label "13"
    cpu 15
    gpu 39
    rom 9
  ]
  edge [
    source 0
    target 1
    bw 11
  ]
  edge [
    source 1
    target 2
    bw 6
  ]
  edge [
    source 2
    target 3
    bw 17
  ]
  edge [
    source 3
    target 4
    bw 1
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
    bw 19
  ]
  edge [
    source 7
    target 8
    bw 22
  ]
  edge [
    source 8
    target 9
    bw 6
  ]
  edge [
    source 9
    target 10
    bw 13
  ]
  edge [
    source 10
    target 11
    bw 41
  ]
  edge [
    source 11
    target 12
    bw 26
  ]
  edge [
    source 12
    target 13
    bw 0
  ]
]
