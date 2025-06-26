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
  id 111
  arrival_time 2054.0159586563473
  lifetime 786.6227405313764
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 11
    gpu 4
    rom 50
  ]
  node [
    id 1
    label "1"
    cpu 45
    gpu 4
    rom 26
  ]
  node [
    id 2
    label "2"
    cpu 41
    gpu 19
    rom 26
  ]
  node [
    id 3
    label "3"
    cpu 47
    gpu 31
    rom 43
  ]
  node [
    id 4
    label "4"
    cpu 28
    gpu 13
    rom 3
  ]
  node [
    id 5
    label "5"
    cpu 34
    gpu 3
    rom 3
  ]
  node [
    id 6
    label "6"
    cpu 29
    gpu 18
    rom 8
  ]
  node [
    id 7
    label "7"
    cpu 8
    gpu 41
    rom 36
  ]
  node [
    id 8
    label "8"
    cpu 17
    gpu 21
    rom 45
  ]
  node [
    id 9
    label "9"
    cpu 16
    gpu 2
    rom 30
  ]
  node [
    id 10
    label "10"
    cpu 17
    gpu 46
    rom 43
  ]
  node [
    id 11
    label "11"
    cpu 8
    gpu 37
    rom 3
  ]
  node [
    id 12
    label "12"
    cpu 47
    gpu 30
    rom 29
  ]
  node [
    id 13
    label "13"
    cpu 39
    gpu 3
    rom 15
  ]
  edge [
    source 0
    target 1
    bw 19
  ]
  edge [
    source 1
    target 2
    bw 40
  ]
  edge [
    source 2
    target 3
    bw 27
  ]
  edge [
    source 3
    target 4
    bw 40
  ]
  edge [
    source 4
    target 5
    bw 36
  ]
  edge [
    source 5
    target 6
    bw 16
  ]
  edge [
    source 6
    target 7
    bw 39
  ]
  edge [
    source 7
    target 8
    bw 20
  ]
  edge [
    source 8
    target 9
    bw 16
  ]
  edge [
    source 9
    target 10
    bw 39
  ]
  edge [
    source 10
    target 11
    bw 25
  ]
  edge [
    source 11
    target 12
    bw 43
  ]
  edge [
    source 12
    target 13
    bw 26
  ]
]
