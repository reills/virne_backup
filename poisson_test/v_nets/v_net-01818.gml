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
  id 1818
  arrival_time 40288.462632551455
  lifetime 39.640021687523934
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 24
    gpu 23
    rom 19
  ]
  node [
    id 1
    label "1"
    cpu 43
    gpu 19
    rom 37
  ]
  node [
    id 2
    label "2"
    cpu 16
    gpu 13
    rom 28
  ]
  node [
    id 3
    label "3"
    cpu 49
    gpu 2
    rom 44
  ]
  node [
    id 4
    label "4"
    cpu 3
    gpu 18
    rom 6
  ]
  node [
    id 5
    label "5"
    cpu 50
    gpu 2
    rom 9
  ]
  node [
    id 6
    label "6"
    cpu 25
    gpu 43
    rom 25
  ]
  node [
    id 7
    label "7"
    cpu 19
    gpu 2
    rom 47
  ]
  node [
    id 8
    label "8"
    cpu 38
    gpu 12
    rom 43
  ]
  node [
    id 9
    label "9"
    cpu 39
    gpu 27
    rom 17
  ]
  node [
    id 10
    label "10"
    cpu 18
    gpu 25
    rom 43
  ]
  node [
    id 11
    label "11"
    cpu 9
    gpu 50
    rom 25
  ]
  node [
    id 12
    label "12"
    cpu 26
    gpu 26
    rom 9
  ]
  node [
    id 13
    label "13"
    cpu 47
    gpu 36
    rom 13
  ]
  node [
    id 14
    label "14"
    cpu 31
    gpu 44
    rom 42
  ]
  edge [
    source 0
    target 1
    bw 37
  ]
  edge [
    source 1
    target 2
    bw 31
  ]
  edge [
    source 2
    target 3
    bw 40
  ]
  edge [
    source 3
    target 4
    bw 10
  ]
  edge [
    source 4
    target 5
    bw 5
  ]
  edge [
    source 5
    target 6
    bw 39
  ]
  edge [
    source 6
    target 7
    bw 20
  ]
  edge [
    source 7
    target 8
    bw 18
  ]
  edge [
    source 8
    target 9
    bw 27
  ]
  edge [
    source 9
    target 10
    bw 8
  ]
  edge [
    source 10
    target 11
    bw 30
  ]
  edge [
    source 11
    target 12
    bw 36
  ]
  edge [
    source 12
    target 13
    bw 49
  ]
  edge [
    source 13
    target 14
    bw 34
  ]
]
