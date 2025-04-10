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
  id 1971
  arrival_time 42985.70965526243
  lifetime 710.4219689749818
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 27
    gpu 44
    rom 19
  ]
  node [
    id 1
    label "1"
    cpu 47
    gpu 1
    rom 27
  ]
  node [
    id 2
    label "2"
    cpu 6
    gpu 20
    rom 46
  ]
  node [
    id 3
    label "3"
    cpu 11
    gpu 50
    rom 9
  ]
  node [
    id 4
    label "4"
    cpu 19
    gpu 33
    rom 36
  ]
  node [
    id 5
    label "5"
    cpu 38
    gpu 15
    rom 19
  ]
  node [
    id 6
    label "6"
    cpu 13
    gpu 15
    rom 39
  ]
  node [
    id 7
    label "7"
    cpu 39
    gpu 4
    rom 29
  ]
  node [
    id 8
    label "8"
    cpu 24
    gpu 27
    rom 32
  ]
  node [
    id 9
    label "9"
    cpu 5
    gpu 4
    rom 6
  ]
  node [
    id 10
    label "10"
    cpu 1
    gpu 4
    rom 12
  ]
  node [
    id 11
    label "11"
    cpu 4
    gpu 27
    rom 22
  ]
  edge [
    source 0
    target 1
    bw 46
  ]
  edge [
    source 1
    target 2
    bw 46
  ]
  edge [
    source 2
    target 3
    bw 26
  ]
  edge [
    source 3
    target 4
    bw 35
  ]
  edge [
    source 4
    target 5
    bw 38
  ]
  edge [
    source 5
    target 6
    bw 3
  ]
  edge [
    source 6
    target 7
    bw 41
  ]
  edge [
    source 7
    target 8
    bw 27
  ]
  edge [
    source 8
    target 9
    bw 35
  ]
  edge [
    source 9
    target 10
    bw 14
  ]
  edge [
    source 10
    target 11
    bw 44
  ]
]
