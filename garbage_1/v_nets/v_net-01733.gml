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
  id 1733
  arrival_time 38762.244573364056
  lifetime 783.4286545156833
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 50
    gpu 44
    rom 6
  ]
  node [
    id 1
    label "1"
    cpu 49
    gpu 2
    rom 22
  ]
  node [
    id 2
    label "2"
    cpu 4
    gpu 45
    rom 42
  ]
  node [
    id 3
    label "3"
    cpu 45
    gpu 15
    rom 38
  ]
  node [
    id 4
    label "4"
    cpu 2
    gpu 1
    rom 17
  ]
  node [
    id 5
    label "5"
    cpu 38
    gpu 5
    rom 38
  ]
  node [
    id 6
    label "6"
    cpu 17
    gpu 2
    rom 40
  ]
  node [
    id 7
    label "7"
    cpu 4
    gpu 39
    rom 45
  ]
  node [
    id 8
    label "8"
    cpu 50
    gpu 31
    rom 7
  ]
  node [
    id 9
    label "9"
    cpu 8
    gpu 14
    rom 31
  ]
  node [
    id 10
    label "10"
    cpu 8
    gpu 30
    rom 22
  ]
  node [
    id 11
    label "11"
    cpu 6
    gpu 2
    rom 41
  ]
  node [
    id 12
    label "12"
    cpu 3
    gpu 3
    rom 29
  ]
  edge [
    source 0
    target 1
    bw 27
  ]
  edge [
    source 1
    target 2
    bw 8
  ]
  edge [
    source 2
    target 3
    bw 35
  ]
  edge [
    source 3
    target 4
    bw 13
  ]
  edge [
    source 4
    target 5
    bw 13
  ]
  edge [
    source 5
    target 6
    bw 9
  ]
  edge [
    source 6
    target 7
    bw 34
  ]
  edge [
    source 7
    target 8
    bw 49
  ]
  edge [
    source 8
    target 9
    bw 2
  ]
  edge [
    source 9
    target 10
    bw 27
  ]
  edge [
    source 10
    target 11
    bw 40
  ]
  edge [
    source 11
    target 12
    bw 47
  ]
]
