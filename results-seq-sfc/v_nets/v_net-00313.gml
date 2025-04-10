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
  id 313
  arrival_time 5846.1370851651
  lifetime 2144.2546991911945
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 45
    gpu 29
    rom 38
  ]
  node [
    id 1
    label "1"
    cpu 10
    gpu 35
    rom 13
  ]
  node [
    id 2
    label "2"
    cpu 9
    gpu 9
    rom 4
  ]
  node [
    id 3
    label "3"
    cpu 40
    gpu 45
    rom 34
  ]
  node [
    id 4
    label "4"
    cpu 35
    gpu 18
    rom 8
  ]
  node [
    id 5
    label "5"
    cpu 42
    gpu 15
    rom 40
  ]
  node [
    id 6
    label "6"
    cpu 50
    gpu 49
    rom 47
  ]
  node [
    id 7
    label "7"
    cpu 1
    gpu 4
    rom 50
  ]
  node [
    id 8
    label "8"
    cpu 24
    gpu 17
    rom 41
  ]
  node [
    id 9
    label "9"
    cpu 47
    gpu 35
    rom 34
  ]
  node [
    id 10
    label "10"
    cpu 1
    gpu 25
    rom 22
  ]
  node [
    id 11
    label "11"
    cpu 25
    gpu 3
    rom 12
  ]
  node [
    id 12
    label "12"
    cpu 23
    gpu 35
    rom 4
  ]
  node [
    id 13
    label "13"
    cpu 6
    gpu 30
    rom 24
  ]
  node [
    id 14
    label "14"
    cpu 3
    gpu 34
    rom 16
  ]
  edge [
    source 0
    target 1
    bw 35
  ]
  edge [
    source 1
    target 2
    bw 2
  ]
  edge [
    source 2
    target 3
    bw 27
  ]
  edge [
    source 3
    target 4
    bw 2
  ]
  edge [
    source 4
    target 5
    bw 38
  ]
  edge [
    source 5
    target 6
    bw 32
  ]
  edge [
    source 6
    target 7
    bw 40
  ]
  edge [
    source 7
    target 8
    bw 32
  ]
  edge [
    source 8
    target 9
    bw 8
  ]
  edge [
    source 9
    target 10
    bw 15
  ]
  edge [
    source 10
    target 11
    bw 43
  ]
  edge [
    source 11
    target 12
    bw 27
  ]
  edge [
    source 12
    target 13
    bw 34
  ]
  edge [
    source 13
    target 14
    bw 36
  ]
]
