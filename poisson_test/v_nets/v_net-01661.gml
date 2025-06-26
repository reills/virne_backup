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
  id 1661
  arrival_time 37071.33308463996
  lifetime 1362.833225584202
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 12
    gpu 9
    rom 31
  ]
  node [
    id 1
    label "1"
    cpu 29
    gpu 0
    rom 18
  ]
  node [
    id 2
    label "2"
    cpu 41
    gpu 38
    rom 1
  ]
  node [
    id 3
    label "3"
    cpu 50
    gpu 27
    rom 24
  ]
  node [
    id 4
    label "4"
    cpu 20
    gpu 46
    rom 16
  ]
  node [
    id 5
    label "5"
    cpu 34
    gpu 17
    rom 35
  ]
  node [
    id 6
    label "6"
    cpu 20
    gpu 9
    rom 25
  ]
  node [
    id 7
    label "7"
    cpu 8
    gpu 26
    rom 12
  ]
  node [
    id 8
    label "8"
    cpu 3
    gpu 24
    rom 19
  ]
  node [
    id 9
    label "9"
    cpu 42
    gpu 25
    rom 37
  ]
  node [
    id 10
    label "10"
    cpu 28
    gpu 0
    rom 50
  ]
  node [
    id 11
    label "11"
    cpu 20
    gpu 42
    rom 3
  ]
  node [
    id 12
    label "12"
    cpu 38
    gpu 47
    rom 4
  ]
  edge [
    source 0
    target 1
    bw 15
  ]
  edge [
    source 1
    target 2
    bw 6
  ]
  edge [
    source 2
    target 3
    bw 6
  ]
  edge [
    source 3
    target 4
    bw 33
  ]
  edge [
    source 4
    target 5
    bw 34
  ]
  edge [
    source 5
    target 6
    bw 23
  ]
  edge [
    source 6
    target 7
    bw 34
  ]
  edge [
    source 7
    target 8
    bw 18
  ]
  edge [
    source 8
    target 9
    bw 0
  ]
  edge [
    source 9
    target 10
    bw 28
  ]
  edge [
    source 10
    target 11
    bw 7
  ]
  edge [
    source 11
    target 12
    bw 50
  ]
]
