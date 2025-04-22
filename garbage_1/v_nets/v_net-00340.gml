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
  id 340
  arrival_time 6389.236070337118
  lifetime 387.7361994408424
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 26
    gpu 44
    rom 14
  ]
  node [
    id 1
    label "1"
    cpu 37
    gpu 30
    rom 32
  ]
  node [
    id 2
    label "2"
    cpu 5
    gpu 41
    rom 39
  ]
  node [
    id 3
    label "3"
    cpu 15
    gpu 33
    rom 45
  ]
  node [
    id 4
    label "4"
    cpu 31
    gpu 46
    rom 18
  ]
  node [
    id 5
    label "5"
    cpu 4
    gpu 48
    rom 9
  ]
  node [
    id 6
    label "6"
    cpu 17
    gpu 16
    rom 6
  ]
  node [
    id 7
    label "7"
    cpu 9
    gpu 32
    rom 14
  ]
  node [
    id 8
    label "8"
    cpu 28
    gpu 17
    rom 3
  ]
  node [
    id 9
    label "9"
    cpu 29
    gpu 2
    rom 37
  ]
  node [
    id 10
    label "10"
    cpu 32
    gpu 37
    rom 47
  ]
  node [
    id 11
    label "11"
    cpu 28
    gpu 25
    rom 8
  ]
  edge [
    source 0
    target 1
    bw 17
  ]
  edge [
    source 1
    target 2
    bw 3
  ]
  edge [
    source 2
    target 3
    bw 8
  ]
  edge [
    source 3
    target 4
    bw 10
  ]
  edge [
    source 4
    target 5
    bw 14
  ]
  edge [
    source 5
    target 6
    bw 18
  ]
  edge [
    source 6
    target 7
    bw 43
  ]
  edge [
    source 7
    target 8
    bw 11
  ]
  edge [
    source 8
    target 9
    bw 48
  ]
  edge [
    source 9
    target 10
    bw 48
  ]
  edge [
    source 10
    target 11
    bw 36
  ]
]
