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
  id 803
  arrival_time 16690.960440958843
  lifetime 833.8572058659172
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 14
    gpu 17
    rom 37
  ]
  node [
    id 1
    label "1"
    cpu 36
    gpu 44
    rom 6
  ]
  node [
    id 2
    label "2"
    cpu 13
    gpu 17
    rom 37
  ]
  node [
    id 3
    label "3"
    cpu 50
    gpu 44
    rom 12
  ]
  node [
    id 4
    label "4"
    cpu 50
    gpu 34
    rom 8
  ]
  node [
    id 5
    label "5"
    cpu 20
    gpu 45
    rom 34
  ]
  node [
    id 6
    label "6"
    cpu 14
    gpu 34
    rom 11
  ]
  node [
    id 7
    label "7"
    cpu 21
    gpu 34
    rom 32
  ]
  node [
    id 8
    label "8"
    cpu 23
    gpu 28
    rom 22
  ]
  node [
    id 9
    label "9"
    cpu 21
    gpu 5
    rom 26
  ]
  node [
    id 10
    label "10"
    cpu 26
    gpu 5
    rom 7
  ]
  edge [
    source 0
    target 1
    bw 5
  ]
  edge [
    source 1
    target 2
    bw 21
  ]
  edge [
    source 2
    target 3
    bw 19
  ]
  edge [
    source 3
    target 4
    bw 18
  ]
  edge [
    source 4
    target 5
    bw 28
  ]
  edge [
    source 5
    target 6
    bw 14
  ]
  edge [
    source 6
    target 7
    bw 41
  ]
  edge [
    source 7
    target 8
    bw 0
  ]
  edge [
    source 8
    target 9
    bw 27
  ]
  edge [
    source 9
    target 10
    bw 28
  ]
]
