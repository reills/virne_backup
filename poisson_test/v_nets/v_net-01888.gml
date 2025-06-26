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
  id 1888
  arrival_time 41564.38586429078
  lifetime 863.1137019685902
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 42
    gpu 24
    rom 16
  ]
  node [
    id 1
    label "1"
    cpu 29
    gpu 33
    rom 37
  ]
  node [
    id 2
    label "2"
    cpu 20
    gpu 5
    rom 2
  ]
  node [
    id 3
    label "3"
    cpu 41
    gpu 40
    rom 45
  ]
  node [
    id 4
    label "4"
    cpu 40
    gpu 50
    rom 24
  ]
  node [
    id 5
    label "5"
    cpu 5
    gpu 45
    rom 1
  ]
  node [
    id 6
    label "6"
    cpu 33
    gpu 2
    rom 37
  ]
  node [
    id 7
    label "7"
    cpu 10
    gpu 25
    rom 14
  ]
  node [
    id 8
    label "8"
    cpu 6
    gpu 48
    rom 5
  ]
  node [
    id 9
    label "9"
    cpu 49
    gpu 30
    rom 5
  ]
  node [
    id 10
    label "10"
    cpu 11
    gpu 28
    rom 8
  ]
  node [
    id 11
    label "11"
    cpu 38
    gpu 23
    rom 44
  ]
  edge [
    source 0
    target 1
    bw 1
  ]
  edge [
    source 1
    target 2
    bw 34
  ]
  edge [
    source 2
    target 3
    bw 36
  ]
  edge [
    source 3
    target 4
    bw 22
  ]
  edge [
    source 4
    target 5
    bw 4
  ]
  edge [
    source 5
    target 6
    bw 19
  ]
  edge [
    source 6
    target 7
    bw 49
  ]
  edge [
    source 7
    target 8
    bw 44
  ]
  edge [
    source 8
    target 9
    bw 15
  ]
  edge [
    source 9
    target 10
    bw 7
  ]
  edge [
    source 10
    target 11
    bw 29
  ]
]
