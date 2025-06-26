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
  id 1824
  arrival_time 40382.55858153729
  lifetime 1424.7048455224876
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 21
    gpu 49
    rom 37
  ]
  node [
    id 1
    label "1"
    cpu 29
    gpu 0
    rom 43
  ]
  node [
    id 2
    label "2"
    cpu 15
    gpu 47
    rom 49
  ]
  node [
    id 3
    label "3"
    cpu 3
    gpu 43
    rom 37
  ]
  node [
    id 4
    label "4"
    cpu 3
    gpu 30
    rom 11
  ]
  node [
    id 5
    label "5"
    cpu 50
    gpu 0
    rom 16
  ]
  node [
    id 6
    label "6"
    cpu 22
    gpu 18
    rom 0
  ]
  node [
    id 7
    label "7"
    cpu 22
    gpu 20
    rom 15
  ]
  node [
    id 8
    label "8"
    cpu 39
    gpu 36
    rom 44
  ]
  node [
    id 9
    label "9"
    cpu 27
    gpu 47
    rom 22
  ]
  node [
    id 10
    label "10"
    cpu 46
    gpu 13
    rom 0
  ]
  node [
    id 11
    label "11"
    cpu 2
    gpu 2
    rom 46
  ]
  node [
    id 12
    label "12"
    cpu 23
    gpu 36
    rom 23
  ]
  node [
    id 13
    label "13"
    cpu 20
    gpu 0
    rom 21
  ]
  edge [
    source 0
    target 1
    bw 20
  ]
  edge [
    source 1
    target 2
    bw 16
  ]
  edge [
    source 2
    target 3
    bw 15
  ]
  edge [
    source 3
    target 4
    bw 22
  ]
  edge [
    source 4
    target 5
    bw 31
  ]
  edge [
    source 5
    target 6
    bw 45
  ]
  edge [
    source 6
    target 7
    bw 23
  ]
  edge [
    source 7
    target 8
    bw 36
  ]
  edge [
    source 8
    target 9
    bw 14
  ]
  edge [
    source 9
    target 10
    bw 36
  ]
  edge [
    source 10
    target 11
    bw 9
  ]
  edge [
    source 11
    target 12
    bw 43
  ]
  edge [
    source 12
    target 13
    bw 28
  ]
]
