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
  id 1903
  arrival_time 41955.26555467621
  lifetime 2053.559215716358
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 50
    gpu 29
    rom 39
  ]
  node [
    id 1
    label "1"
    cpu 3
    gpu 39
    rom 22
  ]
  node [
    id 2
    label "2"
    cpu 40
    gpu 39
    rom 7
  ]
  node [
    id 3
    label "3"
    cpu 19
    gpu 9
    rom 41
  ]
  node [
    id 4
    label "4"
    cpu 36
    gpu 45
    rom 0
  ]
  node [
    id 5
    label "5"
    cpu 39
    gpu 15
    rom 19
  ]
  node [
    id 6
    label "6"
    cpu 46
    gpu 36
    rom 18
  ]
  node [
    id 7
    label "7"
    cpu 0
    gpu 7
    rom 13
  ]
  node [
    id 8
    label "8"
    cpu 46
    gpu 16
    rom 18
  ]
  node [
    id 9
    label "9"
    cpu 31
    gpu 47
    rom 31
  ]
  node [
    id 10
    label "10"
    cpu 10
    gpu 11
    rom 16
  ]
  node [
    id 11
    label "11"
    cpu 13
    gpu 22
    rom 14
  ]
  node [
    id 12
    label "12"
    cpu 39
    gpu 12
    rom 27
  ]
  node [
    id 13
    label "13"
    cpu 14
    gpu 12
    rom 12
  ]
  node [
    id 14
    label "14"
    cpu 34
    gpu 3
    rom 9
  ]
  edge [
    source 0
    target 1
    bw 49
  ]
  edge [
    source 1
    target 2
    bw 41
  ]
  edge [
    source 2
    target 3
    bw 26
  ]
  edge [
    source 3
    target 4
    bw 31
  ]
  edge [
    source 4
    target 5
    bw 18
  ]
  edge [
    source 5
    target 6
    bw 23
  ]
  edge [
    source 6
    target 7
    bw 35
  ]
  edge [
    source 7
    target 8
    bw 41
  ]
  edge [
    source 8
    target 9
    bw 17
  ]
  edge [
    source 9
    target 10
    bw 20
  ]
  edge [
    source 10
    target 11
    bw 16
  ]
  edge [
    source 11
    target 12
    bw 45
  ]
  edge [
    source 12
    target 13
    bw 17
  ]
  edge [
    source 13
    target 14
    bw 42
  ]
]
