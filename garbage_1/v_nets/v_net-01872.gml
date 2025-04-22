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
  id 1872
  arrival_time 41011.58187084611
  lifetime 85.29871413604006
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 35
    gpu 38
    rom 15
  ]
  node [
    id 1
    label "1"
    cpu 18
    gpu 44
    rom 5
  ]
  node [
    id 2
    label "2"
    cpu 36
    gpu 5
    rom 2
  ]
  node [
    id 3
    label "3"
    cpu 42
    gpu 41
    rom 16
  ]
  node [
    id 4
    label "4"
    cpu 9
    gpu 2
    rom 5
  ]
  node [
    id 5
    label "5"
    cpu 35
    gpu 31
    rom 6
  ]
  node [
    id 6
    label "6"
    cpu 33
    gpu 8
    rom 47
  ]
  node [
    id 7
    label "7"
    cpu 30
    gpu 14
    rom 14
  ]
  node [
    id 8
    label "8"
    cpu 2
    gpu 35
    rom 30
  ]
  node [
    id 9
    label "9"
    cpu 33
    gpu 5
    rom 48
  ]
  node [
    id 10
    label "10"
    cpu 13
    gpu 7
    rom 14
  ]
  edge [
    source 0
    target 1
    bw 16
  ]
  edge [
    source 1
    target 2
    bw 49
  ]
  edge [
    source 2
    target 3
    bw 12
  ]
  edge [
    source 3
    target 4
    bw 1
  ]
  edge [
    source 4
    target 5
    bw 47
  ]
  edge [
    source 5
    target 6
    bw 33
  ]
  edge [
    source 6
    target 7
    bw 5
  ]
  edge [
    source 7
    target 8
    bw 30
  ]
  edge [
    source 8
    target 9
    bw 3
  ]
  edge [
    source 9
    target 10
    bw 17
  ]
]
