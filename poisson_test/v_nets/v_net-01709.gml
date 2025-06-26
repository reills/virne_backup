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
  id 1709
  arrival_time 38081.68701695778
  lifetime 1521.8654245616679
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 41
    gpu 17
    rom 16
  ]
  node [
    id 1
    label "1"
    cpu 35
    gpu 36
    rom 28
  ]
  node [
    id 2
    label "2"
    cpu 15
    gpu 20
    rom 47
  ]
  node [
    id 3
    label "3"
    cpu 24
    gpu 49
    rom 17
  ]
  node [
    id 4
    label "4"
    cpu 8
    gpu 13
    rom 50
  ]
  node [
    id 5
    label "5"
    cpu 5
    gpu 18
    rom 28
  ]
  node [
    id 6
    label "6"
    cpu 31
    gpu 45
    rom 26
  ]
  node [
    id 7
    label "7"
    cpu 11
    gpu 46
    rom 46
  ]
  node [
    id 8
    label "8"
    cpu 6
    gpu 43
    rom 2
  ]
  node [
    id 9
    label "9"
    cpu 3
    gpu 50
    rom 43
  ]
  node [
    id 10
    label "10"
    cpu 34
    gpu 27
    rom 24
  ]
  node [
    id 11
    label "11"
    cpu 23
    gpu 14
    rom 29
  ]
  node [
    id 12
    label "12"
    cpu 0
    gpu 10
    rom 7
  ]
  edge [
    source 0
    target 1
    bw 14
  ]
  edge [
    source 1
    target 2
    bw 42
  ]
  edge [
    source 2
    target 3
    bw 38
  ]
  edge [
    source 3
    target 4
    bw 14
  ]
  edge [
    source 4
    target 5
    bw 40
  ]
  edge [
    source 5
    target 6
    bw 8
  ]
  edge [
    source 6
    target 7
    bw 45
  ]
  edge [
    source 7
    target 8
    bw 11
  ]
  edge [
    source 8
    target 9
    bw 23
  ]
  edge [
    source 9
    target 10
    bw 6
  ]
  edge [
    source 10
    target 11
    bw 6
  ]
  edge [
    source 11
    target 12
    bw 36
  ]
]
