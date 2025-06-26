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
  id 1051
  arrival_time 22143.09077952061
  lifetime 112.15213484518829
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 49
    gpu 11
    rom 46
  ]
  node [
    id 1
    label "1"
    cpu 13
    gpu 9
    rom 23
  ]
  node [
    id 2
    label "2"
    cpu 27
    gpu 24
    rom 47
  ]
  node [
    id 3
    label "3"
    cpu 11
    gpu 1
    rom 27
  ]
  node [
    id 4
    label "4"
    cpu 14
    gpu 45
    rom 3
  ]
  node [
    id 5
    label "5"
    cpu 40
    gpu 21
    rom 5
  ]
  node [
    id 6
    label "6"
    cpu 7
    gpu 47
    rom 9
  ]
  node [
    id 7
    label "7"
    cpu 28
    gpu 35
    rom 37
  ]
  node [
    id 8
    label "8"
    cpu 20
    gpu 41
    rom 4
  ]
  node [
    id 9
    label "9"
    cpu 36
    gpu 27
    rom 21
  ]
  node [
    id 10
    label "10"
    cpu 10
    gpu 8
    rom 19
  ]
  node [
    id 11
    label "11"
    cpu 15
    gpu 11
    rom 31
  ]
  node [
    id 12
    label "12"
    cpu 28
    gpu 26
    rom 38
  ]
  node [
    id 13
    label "13"
    cpu 23
    gpu 24
    rom 32
  ]
  edge [
    source 0
    target 1
    bw 7
  ]
  edge [
    source 1
    target 2
    bw 1
  ]
  edge [
    source 2
    target 3
    bw 2
  ]
  edge [
    source 3
    target 4
    bw 18
  ]
  edge [
    source 4
    target 5
    bw 4
  ]
  edge [
    source 5
    target 6
    bw 34
  ]
  edge [
    source 6
    target 7
    bw 20
  ]
  edge [
    source 7
    target 8
    bw 3
  ]
  edge [
    source 8
    target 9
    bw 9
  ]
  edge [
    source 9
    target 10
    bw 47
  ]
  edge [
    source 10
    target 11
    bw 0
  ]
  edge [
    source 11
    target 12
    bw 33
  ]
  edge [
    source 12
    target 13
    bw 6
  ]
]
