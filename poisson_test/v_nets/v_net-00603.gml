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
  id 603
  arrival_time 12467.413927176576
  lifetime 2761.2640222324994
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 14
    gpu 20
    rom 3
  ]
  node [
    id 1
    label "1"
    cpu 48
    gpu 49
    rom 26
  ]
  node [
    id 2
    label "2"
    cpu 43
    gpu 44
    rom 12
  ]
  node [
    id 3
    label "3"
    cpu 41
    gpu 0
    rom 49
  ]
  node [
    id 4
    label "4"
    cpu 37
    gpu 5
    rom 7
  ]
  node [
    id 5
    label "5"
    cpu 48
    gpu 32
    rom 36
  ]
  node [
    id 6
    label "6"
    cpu 9
    gpu 32
    rom 6
  ]
  node [
    id 7
    label "7"
    cpu 16
    gpu 36
    rom 41
  ]
  node [
    id 8
    label "8"
    cpu 0
    gpu 23
    rom 31
  ]
  node [
    id 9
    label "9"
    cpu 35
    gpu 41
    rom 5
  ]
  node [
    id 10
    label "10"
    cpu 33
    gpu 10
    rom 37
  ]
  node [
    id 11
    label "11"
    cpu 9
    gpu 43
    rom 36
  ]
  edge [
    source 0
    target 1
    bw 40
  ]
  edge [
    source 1
    target 2
    bw 8
  ]
  edge [
    source 2
    target 3
    bw 33
  ]
  edge [
    source 3
    target 4
    bw 0
  ]
  edge [
    source 4
    target 5
    bw 25
  ]
  edge [
    source 5
    target 6
    bw 41
  ]
  edge [
    source 6
    target 7
    bw 15
  ]
  edge [
    source 7
    target 8
    bw 9
  ]
  edge [
    source 8
    target 9
    bw 40
  ]
  edge [
    source 9
    target 10
    bw 36
  ]
  edge [
    source 10
    target 11
    bw 22
  ]
]
