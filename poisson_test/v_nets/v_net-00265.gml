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
  id 265
  arrival_time 5215.32429002984
  lifetime 796.443593851037
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 14
    gpu 5
    rom 38
  ]
  node [
    id 1
    label "1"
    cpu 31
    gpu 46
    rom 27
  ]
  node [
    id 2
    label "2"
    cpu 49
    gpu 20
    rom 27
  ]
  node [
    id 3
    label "3"
    cpu 40
    gpu 10
    rom 12
  ]
  node [
    id 4
    label "4"
    cpu 7
    gpu 6
    rom 23
  ]
  node [
    id 5
    label "5"
    cpu 14
    gpu 45
    rom 27
  ]
  node [
    id 6
    label "6"
    cpu 6
    gpu 43
    rom 50
  ]
  node [
    id 7
    label "7"
    cpu 39
    gpu 19
    rom 38
  ]
  node [
    id 8
    label "8"
    cpu 2
    gpu 21
    rom 20
  ]
  node [
    id 9
    label "9"
    cpu 22
    gpu 36
    rom 12
  ]
  node [
    id 10
    label "10"
    cpu 23
    gpu 24
    rom 7
  ]
  node [
    id 11
    label "11"
    cpu 31
    gpu 24
    rom 35
  ]
  edge [
    source 0
    target 1
    bw 17
  ]
  edge [
    source 1
    target 2
    bw 18
  ]
  edge [
    source 2
    target 3
    bw 20
  ]
  edge [
    source 3
    target 4
    bw 15
  ]
  edge [
    source 4
    target 5
    bw 38
  ]
  edge [
    source 5
    target 6
    bw 9
  ]
  edge [
    source 6
    target 7
    bw 24
  ]
  edge [
    source 7
    target 8
    bw 35
  ]
  edge [
    source 8
    target 9
    bw 22
  ]
  edge [
    source 9
    target 10
    bw 16
  ]
  edge [
    source 10
    target 11
    bw 16
  ]
]
