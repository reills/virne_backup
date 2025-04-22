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
  id 874
  arrival_time 18173.705195856353
  lifetime 1132.3547910385014
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 46
    gpu 13
    rom 23
  ]
  node [
    id 1
    label "1"
    cpu 25
    gpu 6
    rom 20
  ]
  node [
    id 2
    label "2"
    cpu 27
    gpu 50
    rom 44
  ]
  node [
    id 3
    label "3"
    cpu 3
    gpu 40
    rom 28
  ]
  node [
    id 4
    label "4"
    cpu 12
    gpu 0
    rom 13
  ]
  node [
    id 5
    label "5"
    cpu 35
    gpu 40
    rom 15
  ]
  node [
    id 6
    label "6"
    cpu 1
    gpu 27
    rom 16
  ]
  node [
    id 7
    label "7"
    cpu 34
    gpu 48
    rom 10
  ]
  node [
    id 8
    label "8"
    cpu 11
    gpu 30
    rom 8
  ]
  node [
    id 9
    label "9"
    cpu 4
    gpu 37
    rom 20
  ]
  node [
    id 10
    label "10"
    cpu 5
    gpu 18
    rom 50
  ]
  node [
    id 11
    label "11"
    cpu 10
    gpu 20
    rom 11
  ]
  node [
    id 12
    label "12"
    cpu 17
    gpu 18
    rom 6
  ]
  edge [
    source 0
    target 1
    bw 46
  ]
  edge [
    source 1
    target 2
    bw 26
  ]
  edge [
    source 2
    target 3
    bw 21
  ]
  edge [
    source 3
    target 4
    bw 1
  ]
  edge [
    source 4
    target 5
    bw 37
  ]
  edge [
    source 5
    target 6
    bw 14
  ]
  edge [
    source 6
    target 7
    bw 2
  ]
  edge [
    source 7
    target 8
    bw 2
  ]
  edge [
    source 8
    target 9
    bw 17
  ]
  edge [
    source 9
    target 10
    bw 30
  ]
  edge [
    source 10
    target 11
    bw 40
  ]
  edge [
    source 11
    target 12
    bw 48
  ]
]
