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
  id 39
  arrival_time 679.68263768883
  lifetime 1989.3899341529386
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 6
    gpu 30
    rom 44
  ]
  node [
    id 1
    label "1"
    cpu 39
    gpu 34
    rom 48
  ]
  node [
    id 2
    label "2"
    cpu 22
    gpu 41
    rom 46
  ]
  node [
    id 3
    label "3"
    cpu 19
    gpu 26
    rom 8
  ]
  node [
    id 4
    label "4"
    cpu 42
    gpu 10
    rom 27
  ]
  node [
    id 5
    label "5"
    cpu 24
    gpu 15
    rom 25
  ]
  node [
    id 6
    label "6"
    cpu 36
    gpu 28
    rom 44
  ]
  node [
    id 7
    label "7"
    cpu 16
    gpu 40
    rom 23
  ]
  node [
    id 8
    label "8"
    cpu 3
    gpu 22
    rom 27
  ]
  node [
    id 9
    label "9"
    cpu 25
    gpu 15
    rom 40
  ]
  node [
    id 10
    label "10"
    cpu 30
    gpu 47
    rom 50
  ]
  node [
    id 11
    label "11"
    cpu 49
    gpu 12
    rom 6
  ]
  edge [
    source 0
    target 1
    bw 41
  ]
  edge [
    source 1
    target 2
    bw 40
  ]
  edge [
    source 2
    target 3
    bw 4
  ]
  edge [
    source 3
    target 4
    bw 2
  ]
  edge [
    source 4
    target 5
    bw 28
  ]
  edge [
    source 5
    target 6
    bw 37
  ]
  edge [
    source 6
    target 7
    bw 33
  ]
  edge [
    source 7
    target 8
    bw 14
  ]
  edge [
    source 8
    target 9
    bw 40
  ]
  edge [
    source 9
    target 10
    bw 25
  ]
  edge [
    source 10
    target 11
    bw 27
  ]
]
