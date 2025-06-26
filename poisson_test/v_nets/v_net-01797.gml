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
  id 1797
  arrival_time 39872.21144334552
  lifetime 1368.1942516729962
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 46
    gpu 6
    rom 31
  ]
  node [
    id 1
    label "1"
    cpu 15
    gpu 18
    rom 2
  ]
  node [
    id 2
    label "2"
    cpu 50
    gpu 29
    rom 9
  ]
  node [
    id 3
    label "3"
    cpu 6
    gpu 9
    rom 26
  ]
  node [
    id 4
    label "4"
    cpu 45
    gpu 12
    rom 32
  ]
  node [
    id 5
    label "5"
    cpu 6
    gpu 39
    rom 34
  ]
  node [
    id 6
    label "6"
    cpu 8
    gpu 37
    rom 1
  ]
  node [
    id 7
    label "7"
    cpu 9
    gpu 0
    rom 20
  ]
  node [
    id 8
    label "8"
    cpu 30
    gpu 39
    rom 41
  ]
  node [
    id 9
    label "9"
    cpu 30
    gpu 30
    rom 38
  ]
  node [
    id 10
    label "10"
    cpu 40
    gpu 10
    rom 5
  ]
  node [
    id 11
    label "11"
    cpu 42
    gpu 1
    rom 39
  ]
  node [
    id 12
    label "12"
    cpu 41
    gpu 45
    rom 20
  ]
  node [
    id 13
    label "13"
    cpu 12
    gpu 9
    rom 0
  ]
  edge [
    source 0
    target 1
    bw 35
  ]
  edge [
    source 1
    target 2
    bw 38
  ]
  edge [
    source 2
    target 3
    bw 32
  ]
  edge [
    source 3
    target 4
    bw 11
  ]
  edge [
    source 4
    target 5
    bw 36
  ]
  edge [
    source 5
    target 6
    bw 5
  ]
  edge [
    source 6
    target 7
    bw 28
  ]
  edge [
    source 7
    target 8
    bw 16
  ]
  edge [
    source 8
    target 9
    bw 15
  ]
  edge [
    source 9
    target 10
    bw 49
  ]
  edge [
    source 10
    target 11
    bw 50
  ]
  edge [
    source 11
    target 12
    bw 27
  ]
  edge [
    source 12
    target 13
    bw 36
  ]
]
