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
  id 287
  arrival_time 5604.407836524059
  lifetime 867.1437592639184
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 46
    gpu 34
    rom 45
  ]
  node [
    id 1
    label "1"
    cpu 15
    gpu 8
    rom 37
  ]
  node [
    id 2
    label "2"
    cpu 46
    gpu 8
    rom 8
  ]
  node [
    id 3
    label "3"
    cpu 36
    gpu 30
    rom 14
  ]
  node [
    id 4
    label "4"
    cpu 22
    gpu 7
    rom 5
  ]
  node [
    id 5
    label "5"
    cpu 36
    gpu 36
    rom 13
  ]
  node [
    id 6
    label "6"
    cpu 13
    gpu 50
    rom 41
  ]
  node [
    id 7
    label "7"
    cpu 3
    gpu 0
    rom 7
  ]
  node [
    id 8
    label "8"
    cpu 13
    gpu 13
    rom 33
  ]
  node [
    id 9
    label "9"
    cpu 18
    gpu 12
    rom 48
  ]
  node [
    id 10
    label "10"
    cpu 1
    gpu 28
    rom 38
  ]
  edge [
    source 0
    target 1
    bw 29
  ]
  edge [
    source 1
    target 2
    bw 38
  ]
  edge [
    source 2
    target 3
    bw 8
  ]
  edge [
    source 3
    target 4
    bw 25
  ]
  edge [
    source 4
    target 5
    bw 6
  ]
  edge [
    source 5
    target 6
    bw 3
  ]
  edge [
    source 6
    target 7
    bw 13
  ]
  edge [
    source 7
    target 8
    bw 23
  ]
  edge [
    source 8
    target 9
    bw 9
  ]
  edge [
    source 9
    target 10
    bw 21
  ]
]
